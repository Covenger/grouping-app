import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouping/common/btn_sign_in.dart';
import 'package:grouping/common/colors.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

final Widget passwordIcon = SvgPicture.asset(
  'assets/svg/password_icon.svg',
  semanticsLabel: 'Password Icon',
);

final Widget emailIcon = SvgPicture.asset(
  'assets/svg/email_icon.svg',
  semanticsLabel: 'Email Icon',
);

class _SignInPageState extends State<SignInPage> {
  static const _textFieldHintStyle = const TextStyle(color: const Color(0xFFE1E1E1));
  static const _textFieldStyle = const TextStyle(
    color: Colors.white,
    fontFamily: 'NotoSansCJKkr',
    fontSize: 20,
  );
  static const _textFieldEnabledBorder = const UnderlineInputBorder(
    borderSide: const BorderSide(color: const Color(0xFF9397FF)),
  );
  static const _textFieldFocusedBorder = const UnderlineInputBorder(
    borderSide: const BorderSide(color: SelectedButtonBorder),
  );

  static const _titleText = Text(
    'Grouping',
    style: const TextStyle(
      fontSize: 24,
      fontFamily: 'BrownFox',
      color: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor,
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 60,
        decoration: const BoxDecoration(
            border: const Border(
          top: const BorderSide(
            width: 1,
            color: const Color(0xFF9397FF),
            style: BorderStyle.solid,
          ),
        )),
        child: GestureDetector(
          child: const Text(
            'Do you need help?',
            style: const TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
              fontFamily: 'NotoSansCJKkr',
              fontSize: 14,
            ),
          ),
          // TODO
          onTap: () => print('need help'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Center(child: _titleText),
          const SizedBox(height: 70),
          Form(
            autovalidate: true,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      _buildEmailField(),
                      const SizedBox(height: 30),
                      _buildPasswordField(),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SignInButton(
                  btnColor: Colors.white,
                  contents: 'Sign in',
                  // TODO
                  onPress: () => print('asdf'),
                  textColor: const Color(0xFF3338D0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    child: const Text(
                      'Join us',
                      style: const TextStyle(
                        fontFamily: 'NotoSansCJKkr',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/signup/email'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  static TextFormField _buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: _textFieldStyle,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        enabledBorder: _textFieldEnabledBorder,
        focusedBorder: _textFieldFocusedBorder,
        hintText: 'example@example.com',
        hintStyle: _textFieldHintStyle,
        icon: emailIcon,
      ),
    );
  }

  static TextFormField _buildPasswordField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      style: _textFieldStyle,
      obscureText: true,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        enabledBorder: _textFieldEnabledBorder,
        focusedBorder: _textFieldFocusedBorder,
        hintText: '•••••••',
        hintStyle: _textFieldHintStyle,
        icon: passwordIcon,
        suffixIcon: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          tooltip: 'Show password',
          // TODO
          color: Colors.white,
//          color: state.hidePw ? Colors.grey : const Color(0xFF3338D0),
          // TODO
          onPressed: () => print('pressed'),
        ),
      ),
    );
  }
}
