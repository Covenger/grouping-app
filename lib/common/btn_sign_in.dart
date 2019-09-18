import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String contents;
  final Color btnColor, textColor;
  final double width;
  final Function onPress;

  const SignInButton({
    Key key,
    @required this.contents,
    @required this.onPress,
    @required this.btnColor,
    @required this.textColor,
    this.width = 230.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      color: btnColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      padding: EdgeInsets.symmetric(vertical: 19, horizontal: 25),
      child: Container(
        width: width,
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Spacer(flex: 1),
            Expanded(
              flex: 1,
              child: Text(
                contents,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'NotoSansCJKkr',
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_forward, color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
