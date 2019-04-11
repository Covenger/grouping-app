import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/* Events */

@immutable
abstract class SignInFormEvent extends Equatable {
  SignInFormEvent([List props = const []]) : super(props);
}

class PasswordChanged extends SignInFormEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class EmailChanged extends SignInFormEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email: $email }';
}

class PasswordVisibilityChanged extends SignInFormEvent {}

/* State */

@immutable
class SignInFormState extends Equatable {
  final String email;
  final bool isEmailValid;
  final String password;
  final String errMsg;
  final bool hidePw;

  SignInFormState({
    @required this.email,
    @required this.isEmailValid,
    @required this.password,
    @required this.errMsg,
    @required this.hidePw,
  }) : super([
          email,
          isEmailValid,
          password,
          errMsg,
          hidePw,
        ]);

  factory SignInFormState.initial() {
    return SignInFormState(
      email: '',
      password: '',
      isEmailValid: false,
      errMsg: '',
      hidePw: true,
    );
  }

  SignInFormState copyWith({
    String email,
    bool isEmailValid,
    String password,
    String errMsg,
    bool hidePw,
  }) {
    return SignInFormState(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      password: password ?? this.password,
      errMsg: errMsg ?? this.errMsg,
      hidePw: hidePw ?? this.hidePw,
    );
  }
}

/* Bloc */

class SignInBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final RegExp _emailRegExp = RegExp(
    r'''^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$''',
  );

  @override
  SignInFormState get initialState => SignInFormState.initial();

  @override
  Stream<SignInFormState> mapEventToState(SignInFormEvent event) async* {
    if (event is PasswordChanged) {
      yield currentState.copyWith(password: event.password);
    }

    if (event is EmailChanged) {
      var isEmailValid = _emailRegExp.hasMatch(event.email);
      yield currentState.copyWith(email: event.email, isEmailValid: isEmailValid);
    }

    if (event is PasswordVisibilityChanged) {
      yield currentState.copyWith(hidePw: !currentState.hidePw);
    }
  }
}
