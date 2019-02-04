import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grouping/common/form_frame.dart';

class NamePage extends StatefulWidget {
  final FlutterSecureStorage _storage;

  NamePage({Key key, @required storage})
      : _storage = storage,
        super(key: key);

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _nameFieldController = TextEditingController();

  bool _isNameValidated = false;

  @override
  void dispose() {
    super.dispose();
    _nameFieldController.dispose();
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
                'Enter your name',
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
                hintText: 'You Name',
                hintStyle: const TextStyle(color: const Color(0xFFE1E1E1)),
              ),
              controller: _nameFieldController,
              onChanged: _validateForm,
              onSubmitted: (val) async {
                _validateForm(val);
                if (_isNameValidated) {
                  await widget._storage.write(key: 'name', value: val);
                  _nextPage();
                }
              },
            ),
          ],
        ),
      ),
      onSubmit: !_isNameValidated ? null : _nextPage,
    );
  }

  void _nextPage() => Navigator.pushNamed(context, '/');

  void _validateForm(String val) {
    final validateResult = val.length >= 2;

    if (_isNameValidated ^ validateResult) {
      setState(() {
        _isNameValidated = validateResult;
      });
    }
  }
}
