import 'package:flutter/material.dart';
import 'package:grouping/common/colors.dart';
import 'package:grouping/signin.dart';
import 'package:grouping/signup/email.dart';
import 'package:grouping/signup/gender_n_birth.dart';
import 'package:grouping/signup/name.dart';
import 'package:grouping/signup/password.dart';
import 'package:grouping/signup/validation_code.dart';
import 'package:grouping/splash/main.dart';

void main() => runApp(Grouping());

class Grouping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: check sign-in
    String initialRoute = '/';

    return MaterialApp(
      title: 'Grouping',
      theme: ThemeData(primaryColor: PrimaryColor),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => SplashPage(),
        '/signin': (context) => SignInPage(),
        '/signup/email': (context) => EmailPage(),
        '/signup/password': (context) => PasswordPage(),
        '/signup/name': (context) => NamePage(),
        '/signup/gender_n_birth': (context) => GenderNBirthPage(),
        '/signup/validate': (context) => ValidateCodePage(),
      },
    );
  }
}
