import 'package:ex_architectures/hexagonal/di/auth_module.dart';
import 'package:ex_architectures/hexagonal/entites/user.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthService with LoadUserUseCase, LoginUseCase, LogoutUseCase {
  const AuthService(this.loginPort, this.logoutPort, this.loadUserPort);

  final LoginPort loginPort;
  final LogoutPort logoutPort;
  final LoadUserPort loadUserPort;

  @override
  Stream<User?> loadUser() {
    return loadUserPort.loadUser();
  }

  @override
  Future<User> login(LoginCommand loginCommand) {
    return loginPort.login(loginCommand.email, loginCommand.password);
  }

  @override
  Future logout() {
    return logoutPort.logout();
  }
}
