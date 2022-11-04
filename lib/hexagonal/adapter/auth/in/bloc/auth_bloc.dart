import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ex_architectures/hexagonal/di/auth_module.dart';
import 'package:ex_architectures/hexagonal/entites/user.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this.loginUseCase,
    this.logoutUseCase,
    this.loadUserUseCase,
  ) : super(AuthInitial()) {
    on<LoginAuthEvent>((event, emit) async {
      final loginCommand = LoginCommand(event.email, event.password);
      final user = await loginUseCase.login(loginCommand);
      emit(AuthLoggedInState(user));
    });

    on<LogoutAuthEvent>((event, emit) async {
      await logoutUseCase.logout();
      emit(UnauthState());
    });

    on<OnUserChangedEvent>((event, emit) {
      if (event.user == null) {
        return emit(UnauthState());
      }
      return emit(AuthLoggedInState(event.user!));
    });

    subscribeToUserChanges();
  }

  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final LoadUserUseCase loadUserUseCase;

  StreamSubscription? streamSubscription;

  Future subscribeToUserChanges() async {
    streamSubscription = loadUserUseCase.loadUser().listen(
          (user) => add(OnUserChangedEvent(user)),
        );
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}

@immutable
abstract class AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  LoginAuthEvent(this.email, this.password);

  final String email;
  final String password;
}

class LogoutAuthEvent extends AuthEvent {}

class OnUserChangedEvent extends AuthEvent {
  OnUserChangedEvent(this.user);

  final User? user;
}

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User user;

  AuthLoggedInState(this.user);
}

class UnauthState extends AuthState {}
