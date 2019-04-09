import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@immutable
class EmailFormState extends Equatable {
  final String email;
  final bool isValid;
  final String errMsg;

  EmailFormState({
    @required this.email,
    @required this.isValid,
    @required this.errMsg,
  }) : super([
          email,
          isValid,
          errMsg,
        ]);

  factory EmailFormState.initial() {
    return EmailFormState(
      email: '',
      isValid: false,
      errMsg: '',
    );
  }
}

class EmailBloc extends Bloc<String, EmailFormState> {
  final RegExp _emailRegExp = RegExp(
    r'''^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$''',
  );

  @override
  EmailFormState get initialState => EmailFormState.initial();

  @override
  Stream<EmailFormState> mapEventToState(String email) async* {
    if (!_emailRegExp.hasMatch(email)) {
      yield new EmailFormState(email: email, isValid: false, errMsg: 'Please enter a valid email address');
    } else {
      // TODO: Confirm email duplication
      yield new EmailFormState(email: email, isValid: true, errMsg: null);
    }
  }
}
