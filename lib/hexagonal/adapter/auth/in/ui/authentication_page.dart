import 'package:ex_architectures/hexagonal/adapter/auth/in/bloc/auth_bloc.dart';
import 'package:ex_architectures/hexagonal/adapter/auth/in/ui/loading_page.dart';
import 'package:ex_architectures/hexagonal/adapter/auth/in/ui/login_page/login_page.dart';
import 'package:ex_architectures/hexagonal/adapter/auth/in/ui/user_info_page.dart';
import 'package:ex_architectures/hexagonal/di/auth_module.dart';
import 'package:ex_architectures/hexagonal/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        injector.get<LoginUseCase>(),
        injector.get<LogoutUseCase>(),
        injector.get<LoadUserUseCase>(),
      ),
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Navigator(
              pages: [
                if (state is UnauthState) const MaterialPage(child: LoginPage()),
                if (state is AuthLoggedInState) MaterialPage(child: UserInfoPage(user: state.user)),
                if (state is AuthInitial) const MaterialPage(child: LoadingPage()),
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          },
        ),
      ),
    );
  }
}
