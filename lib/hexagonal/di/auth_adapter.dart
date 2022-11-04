import 'package:ex_architectures/hexagonal/di/auth_module.dart';
import 'package:ex_architectures/hexagonal/entites/user.dart' as user;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_hexagonal/di/auth_module.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthAdapter with LoginPort, LogoutPort, LoadUserPort {
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<user.User> login(String email, String password) async {
    // final userCredentials = await firebaseAuth.signInWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );

    // if (userCredentials.user == null) {
    //   throw UserNotFound();
    // }

    // final firebaseUser = userCredentials.user!;

    return user.User('firebaseUser.email!');
  }

  @override
  Future logout() => Future.error(Exception()); //FirebaseAuth.instance.signOut();

  @override
  Stream<user.User?> loadUser() {
    // return firebaseAuth.userChanges().map((currentUser) {
    //   return currentUser == null ? null : user.User(currentUser.email!);
    // });
    return Stream.empty();
  }
}
