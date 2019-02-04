import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grouping/common/form_frame.dart';

class EmailPage extends StatefulWidget {
  final FlutterSecureStorage _storage;

  EmailPage({Key key, @required storage})
      : _storage = storage,
        super(key: key);

  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final _emailFieldController = TextEditingController();
  static final RegExp _emailRegex = RegExp(
      r'''^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$''');

  bool _isEmailValidated = false;

  @override
  void dispose() {
    super.dispose();
    _emailFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            TextField(
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
              controller: _emailFieldController,
              onChanged: _validateForm,
              onSubmitted: (val) {
                _validateForm(val);
                if (_isEmailValidated) {
                  widget._storage.write(key: 'email', value: val);
                  _nextPage();
                }
              },
            ),
          ],
        ),
      ),
      onSubmit: !_isEmailValidated ? null : _nextPage,
    );
  }

  void _nextPage() => Navigator.pushNamed(context, '/signup/password');

  void _validateForm(String val) {
    final validateResult = _emailRegex.hasMatch(val);

    if (_isEmailValidated ^ validateResult) {
      setState(() {
        _isEmailValidated = validateResult;
      });
    }
  }
}
