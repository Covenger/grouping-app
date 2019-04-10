import 'package:flutter/material.dart';
import 'package:grouping/splash/background.dart';
import 'package:grouping/splash/contents.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 6200),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          SplashBackground(controller: animationController.view),
          SplashContents(
            controller: animationController.view,
            onJoin: () => Navigator.pushNamed(context, '/signup/email'),
            // FIXME: hard coded
            onSignIn: () => print('sign in btn'),
          )
        ],
      ),
    );
  }
}
