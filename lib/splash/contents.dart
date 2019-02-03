import 'package:flutter/material.dart';
import 'package:grouping/common/btn_sign_in.dart';

class SplashContents extends StatelessWidget {
  final Animation<double> controller;
  final Animation<double> titleUp;
  final Animation<double> buttonUp;

  final Function onJoin, onSignIn;

  SplashContents({Key key, @required this.controller, @required this.onJoin, @required this.onSignIn})
      // Each animation defined here transforms its value during the subset
      // of the controller's duration defined by the animation's interval.
      : titleUp = Tween<double>(
          begin: 0.0,
          // FIXME: hard coded
          end: -110.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.873015873, 0.936507937),
          ),
        ),
        buttonUp = Tween<double>(
          // FIXME: hard coded
          begin: 600,
          end: 40,
        ).animate(
          CurvedAnimation(
            parent: controller,
            // custom curve: http://cubic-bezier.com/#.55,.63,.23,1.2
            curve: Interval(0.936507937, 1.0, curve: Cubic(.55, .63, .23, 1.2)),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleText = Text(
      'Grouping',
      style: TextStyle(
        fontSize: 24,
        fontFamily: 'BrownFox',
        color: Colors.white,
      ),
    );

    final buttonBox = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SignInButton(
          textColor: Colors.white,
          btnColor: Theme.of(context).primaryColor,
          contents: 'JOIN US',
          onPress: onJoin,
        ),
        SizedBox(height: 15),
        SignInButton(
          textColor: Color(0xFF3338D0),
          btnColor: Colors.white,
          contents: 'Sign in',
          onPress: onSignIn,
        ),
      ],
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) => Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Transform.translate(
                child: titleText,
                offset: Offset(0, titleUp.value),
              ),
              Transform.translate(
                offset: Offset(0, buttonUp.value),
                child: buttonBox,
              ),
            ],
          ),
    );
  }
}
