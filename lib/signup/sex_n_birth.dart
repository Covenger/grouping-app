import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grouping/common/colors.dart';
import 'package:grouping/common/form_frame.dart';
import 'package:grouping/common/radio_button.dart';

enum Gender { Male, Female }

class SexNBirthPage extends StatefulWidget {
  final FlutterSecureStorage _storage;

  SexNBirthPage({Key key, @required storage})
      : _storage = storage,
        super(key: key);

  @override
  _SexNBirthPageState createState() => _SexNBirthPageState();
}

class _SexNBirthPageState extends State<SexNBirthPage> {
  DateTime _birthDay;
  Gender _gender = Gender.Male;
  bool _isAllValidated = false;

  bool get isBirthValid => _birthDay != null;

  @override
  void initState() {
    super.initState();
    widget._storage.write(key: 'gender', value: _gender.toString());
  }

  @override
  Widget build(BuildContext context) {
    return FormFrame(
      content: Align(
        alignment: const Alignment(0, -0.6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RadioButton(
                  value: Gender.Male,
                  groupValue: _gender,
                  onChanged: _updateGender,
                  child: const Text(
                    '\u{2642}', // ♂
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                RadioButton(
                  value: Gender.Female,
                  groupValue: _gender,
                  onChanged: _updateGender,
                  child: const Text(
                    '\u{2640}', // ♀
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 320,
              child: FlatButton(
                onPressed: _selectBirthday,
                child: Text(
                  isBirthValid ? '${_birthDay.year}.${_birthDay.month}.${_birthDay.day}' : 'Select birthday',
                  style: TextStyle(
                    color: isBirthValid ? SelectedButtonText : UnselectedButtonText,
                    fontSize: 18,
                  ),
                ),
                color: isBirthValid ? SelectedButton : UnselectedButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: isBirthValid ? SelectedButtonBorder : UnselectedButtonBorder,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onSubmit: !_isAllValidated ? null : _nextPage,
    );
  }

  void _nextPage() => Navigator.pushNamed(context, '/');

  void _validateForm() {
    final validateResult = _birthDay != null && _gender != null;

    if (_isAllValidated ^ validateResult) {
      setState(() {
        _isAllValidated = validateResult;
      });
    }
  }

  Future<void> _updateGender(Gender newGender) async {
    if (_gender != newGender) {
      await widget._storage.write(key: 'gender', value: _gender.toString());
      setState(() => _gender = newGender);
      _validateForm();
    }
  }

  Future<void> _selectBirthday() async {
    final DateTime birthDay = await showDatePicker(
      context: context,
      initialDate: _birthDay != null ? _birthDay : DateTime.now(),
      firstDate: DateTime(1910),
      lastDate: DateTime.now(),
    );

    if (birthDay != null) {
      await widget._storage.write(key: 'birthday', value: birthDay.toIso8601String());
      setState(() => _birthDay = birthDay);
      _validateForm();
    }
  }
}
