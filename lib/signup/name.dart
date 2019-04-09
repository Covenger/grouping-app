import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouping/blocks/signup/name.dart';
import 'package:grouping/common/form_frame.dart';

class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _nameBloc = NameBloc();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onNameChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _nameBloc,
      builder: (BuildContext context, NameFormState state) {
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
                    'Enter your name',
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
                  decoration: const InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    hintText: 'Your Name',
                    hintStyle: const TextStyle(color: const Color(0xFFE1E1E1)),
                  ),
                  controller: _nameController,
                  autovalidate: true,
                  validator: (_) => state.isValid ? null : state.errMsg,
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

  void _onNameChanged() {
    _nameBloc.dispatch(_nameController.text);
  }

  void _onFieldSubmitted(String val) {
    if (_nameBloc.currentState.isValid) {
      _nextPage();
    }
  }

  void _nextPage() => Navigator.pushNamed(context, '/signup/sex_n_birth');
}
