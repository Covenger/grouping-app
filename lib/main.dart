import 'package:flutter/material.dart';
import 'package:grouping/common/colors.dart';
import 'package:grouping/signin.dart';
import 'package:grouping/splash/main.dart';

import 'signup/signup.dart';

void main() => runApp(Grouping());

class Grouping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: check sign-in
    String initialRoute = SplashPage.routeName;

    return MaterialApp(
      title: 'Grouping',
      theme: ThemeData(primaryColor: PrimaryColor),
      initialRoute: initialRoute,
      routes: {
        SplashPage.routeName: (context) => SplashPage(),
        SignInPage.routeName: (context) => SignInPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
      },
    );
  }
}
