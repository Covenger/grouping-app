import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grouping/signup/email.dart';
import 'package:grouping/signup/name.dart';
import 'package:grouping/signup/password.dart';
import 'package:grouping/signup/sex_n_birth.dart';
import 'package:grouping/splash/main.dart';

void main() => runApp(Grouping());

class Grouping extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO: check sign-in
    String initialRoute = '/';
    var storage = FlutterSecureStorage();

    return MaterialApp(
      title: 'Grouping',
      theme: ThemeData(primaryColor: const Color(0xFF7579F6)),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => SplashPage(),
        '/signup/email': (context) => EmailPage(),
        '/signup/password': (context) => PasswordPage(storage: storage),
        '/signup/name': (context) => NamePage(storage: storage),
        '/signup/sex_n_birth': (context) => SexNBirthPage(storage: storage),
      },
    );
  }
}
