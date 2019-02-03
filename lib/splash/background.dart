import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  final Animation<double> controller;
  final Animation<double> fadeIn;
  final Animation<double> sliding;

  SplashBackground({Key key, @required this.controller})
      // Each animation defined here transforms its value during the subset
      // of the controller's duration defined by the animation's interval.
      : fadeIn = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.317460317, 0.476190476),
          ),
        ),
        sliding = Tween<double>(
          begin: -1.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.317460317, 0.873015873, curve: Curves.ease),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final background = Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    );
    const assetImage = AssetImage('assets/png/splash.png');

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) => Stack(
            children: <Widget>[
              background,
              Opacity(
                opacity: fadeIn.value,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: assetImage,
                      fit: BoxFit.cover,
                      alignment: Alignment(sliding.value, 0),
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
