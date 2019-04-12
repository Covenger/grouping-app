import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouping/blocks/signup/validation_code.dart';
import 'package:grouping/common/colors.dart';
import 'package:grouping/common/form_frame.dart';

class ValidateCodePage extends StatefulWidget {
  @override
  _ValidateCodePageState createState() => _ValidateCodePageState();
}

class _ValidateCodePageState extends State<ValidateCodePage> {
  final _codeBloc = ValidationCodeBloc();
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _codeController.addListener(_onCodeChanged);
  }

  @override
  void dispose() {
    _codeController.dispose();
    _codeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _codeBloc,
      builder: (BuildContext context, ValidationCodeFormState state) {
        return FormFrame(
          content: Container(
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: const Text(
                          'Enter your code',
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
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 6,
                        decoration: const InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          hintText: '000000',
                          hintStyle: const TextStyle(color: const Color(0xFFE1E1E1)),
                        ),
                        controller: _codeController,
                        autovalidate: true,
                        validator: (_) => state.isValid ? null : state.errMsg,
                        onFieldSubmitted: _onFieldSubmitted,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: GestureDetector(
                    onTap: _onResend,
                    child: Text(
                      'Send New Code',
                      style: TextStyle(
                        color: SelectedButtonBorder,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          onSubmit: state.isValid ? _nextPage : null,
          confirmWidgets: <Widget>[
            Text(
              'Done !',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  void _onCodeChanged() {
    _codeBloc.dispatch(CodeChanged(code: _codeController.text));
  }

  void _onFieldSubmitted(String _) {
    if (_codeBloc.currentState.isValid) {
      // TODO
      _nextPage();
    }
  }

  void _onResend() {
    _codeBloc.dispatch(ResendCode());
  }

  void _nextPage() => Navigator.pushNamed(context, '/');
}
