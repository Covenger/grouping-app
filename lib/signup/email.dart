import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouping/blocks/signup/email.dart';
import 'package:grouping/common/form_frame.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final EmailBloc _emailBloc = EmailBloc();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _emailBloc,
      builder: (BuildContext context, EmailFormState state) {
        return FormFrame(
          content: Align(
            alignment: const Alignment(0, -0.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: const Text(
                    'Enter your email',
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
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.go,
                  decoration: const InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    hintText: 'example@example.com',
                    hintStyle: const TextStyle(color: const Color(0xFFE1E1E1)),
                  ),
                  controller: _emailController,
                  autovalidate: true,
                  validator: (_) => state.isValid ? null : state.errMsg,
                ),
              ],
            ),
          ),
          onSubmit: state.isValid ? _nextPage : null,
        );
      },
    );
  }

  void _onEmailChanged() {
    _emailBloc.dispatch(_emailController.text);
  }

  void _nextPage() => Navigator.pushNamed(context, '/signup/password');
}
