import 'package:ex_architectures/hexagonal/di/auth_adapter.dart';
import 'package:ex_architectures/hexagonal/di/auth_service.dart';
import 'package:ex_architectures/hexagonal/entites/user.dart';
import 'package:ex_architectures/hexagonal/main.dart';
import 'package:injectable/injectable.dart';

/// https://github.com/lapin7771n/flutter-hexagonal-architecture
@module
abstract class AuthModule {
  LoadUserUseCase get loadUserUseCase => injector.get<AuthService>();
  LoginUseCase get loginUseCase => injector.get<AuthService>();
  LogoutUseCase get logoutUseCase => injector.get<AuthService>();

  LoadUserPort get loadUserPort => injector.get<AuthAdapter>();
  LoginPort get loginPort => injector.get<AuthAdapter>();
  LogoutPort get logoutPort => injector.get<AuthAdapter>();
}

abstract class LoadUserUseCase {
  Stream<User?> loadUser();
}

abstract class LoginUseCase {
  Future<User> login(LoginCommand loginCommand);
}

class LoginCommand {
  final String email;
  final String password;

  LoginCommand(this.email, this.password)
      : assert(email.isValidEmail),
        assert(password.isValidPassword);
}

abstract class LogoutUseCase {
  Future logout();
}

// =========================================================================== out ports

abstract class LoadUserPort {
  Stream<User?> loadUser();
}

abstract class LoginPort {
  Future<User> login(String email, String password);
}

abstract class LogoutPort {
  Future logout();
}

// =========================================================================== util

class UserNotFound with Exception {}

// TODO: move it to util class
extension Validator on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    return length >= 8;
  }
}
