import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouping/blocks/signup/password.dart';
import 'package:grouping/common/form_frame.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _passwordBloc = PasswordBloc();
  final _pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pwController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _pwController.dispose();
    _passwordBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _passwordBloc,
      builder: (BuildContext context, PasswordFormState state) {
        return FormFrame(
          content: Container(
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: const Text(
                    'Password',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: 'NotoSansCJKkr',
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 50, top: 15, bottom: 15),
                    hintText: '8+ characters',
                    hintStyle: const TextStyle(color: const Color(0xFFE1E1E1)),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: const Icon(Icons.remove_red_eye),
                        tooltip: 'Show password',
                        color: state.hidePw ? Colors.grey : const Color(0xFF3338D0),
                        onPressed: _onVisibilityChanged,
                      ),
                    ),
                  ),
                  controller: _pwController,
                  autovalidate: true,
                  validator: (_) => state.isValid ? null : state.errMsg,
                  obscureText: state.hidePw,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
              ],
            ),
          ),
          onSubmit: state.isValid ? _nextPage : null,
        );
      },
    );
  }

  void _onPasswordChanged() {
    _passwordBloc.dispatch(PasswordChanged(password: _pwController.text));
  }

  void _onVisibilityChanged() {
    _passwordBloc.dispatch(PasswordVisibilityChanged());
  }

  void _onFieldSubmitted(String val) {
    if (_passwordBloc.currentState.isValid) {
      _nextPage();
    }
  }

  void _nextPage() => Navigator.pushNamed(context, '/signup/name');
}
