import 'package:ex_architectures/hexagonal/adapter/auth/in/ui/authentication_page.dart';
import 'package:ex_architectures/hexagonal/main.config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  configureDependencies();
  runApp(const AuthenticationPage());
}

final injector = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(injector);
