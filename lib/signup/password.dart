import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grouping/common/form_frame.dart';

class PasswordPage extends StatefulWidget {
  final FlutterSecureStorage _storage;

  PasswordPage({Key key, @required storage})
      : _storage = storage,
        super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _pwFieldController = TextEditingController();

  bool _isPWValidated = false;
  bool _hidePW = true;

  @override
  void dispose() {
    super.dispose();
    _pwFieldController.dispose();
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
                'Password',
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
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 50, top: 15, bottom: 15),
                hintText: '8+ characters',
                hintStyle: const TextStyle(color: const Color(0xFFE1E1E1)),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    tooltip: 'Show password',
                    color: _hidePW ? Colors.grey : const Color(0xFF3338D0),
                    onPressed: () => setState(() => _hidePW = !_hidePW),
                  ),
                ),
              ),
              controller: _pwFieldController,
              onChanged: _validateForm,
              onSubmitted: (val) async {
                _validateForm(val);
                if (_isPWValidated) {
                  await widget._storage.write(key: 'password', value: val);
                  _nextPage();
                }
              },
              obscureText: _hidePW,
            ),
          ],
        ),
      ),
      onSubmit: !_isPWValidated ? null : _nextPage,
    );
  }

  void _nextPage() => Navigator.pushNamed(context, '/signup/email');

  void _validateForm(String val) {
    final validateResult = val.length >= 8;

    if (_isPWValidated ^ validateResult) {
      setState(() {
        _isPWValidated = validateResult;
      });
    }
  }
}
