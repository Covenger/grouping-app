import 'package:flutter/material.dart';
import 'package:grouping/splash/main.dart';

void main() => runApp(Grouping());

class Grouping extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grouping',
      theme: ThemeData(primaryColor: Color(0xFF7579F6)),
      home: SplashPage(),
    );
  }
}
