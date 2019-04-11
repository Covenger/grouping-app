import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouping/blocks/signin.dart';
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
  static const _textFieldHintStyle = const TextStyle(color: const Color(0xCCFFFFFF));
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

  final _signInBloc = SignInBloc();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _signInBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pwFocus = FocusNode();

    return Scaffold(
      backgroundColor: PrimaryColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                const Center(child: _titleText),
                const SizedBox(height: 70),
                BlocBuilder(
                    bloc: _signInBloc,
                    builder: (BuildContext context, SignInFormState state) {
                      return Form(
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                _buildEmailField(context, state, pwFocus),
                                const SizedBox(height: 20),
                                _buildPasswordField(state, pwFocus),
                              ],
                            ),
                            const SizedBox(height: 50),
                            SignInButton(
                              btnColor: Colors.white,
                              contents: 'Sign in',
                              // TODO
                              onPress: () => print('asdf'),
                              textColor: const Color(0xFF3338D0),
                            ),
                            _buildJoinButton(context)
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
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
          ),
        ),
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
    );
  }

  static Padding _buildJoinButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
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
    );
  }

  TextFormField _buildEmailField(BuildContext context, SignInFormState state, FocusNode pwFocus) {
    return TextFormField(
      cursorColor: Colors.white,
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
      controller: _emailController,
      autovalidate: true,
      validator: (_) => state.isEmailValid ? null : 'Please enter a valid email address',
      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(pwFocus),
    );
  }

  TextFormField _buildPasswordField(SignInFormState state, FocusNode pwFocus) {
    return TextFormField(
      cursorColor: Colors.white,
      focusNode: pwFocus,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      style: _textFieldStyle,
      obscureText: state.hidePw,
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
          color: state.hidePw ? Colors.grey : Colors.white,
          onPressed: _onVisibilityChanged,
        ),
      ),
    );
  }

  void _onEmailChanged() {
    _signInBloc.dispatch(EmailChanged(email: _emailController.text));
  }

  void _onVisibilityChanged() {
    _signInBloc.dispatch(PasswordVisibilityChanged());
  }
}
