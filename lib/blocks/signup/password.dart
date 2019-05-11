import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/* Events */

@immutable
abstract class PasswordFormEvent extends Equatable {
  PasswordFormEvent([List props = const []]) : super(props);
}

class PasswordChanged extends PasswordFormEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class PasswordVisibilityChanged extends PasswordFormEvent {}

/* State */

@immutable
class PasswordFormState extends Equatable {
  final String password;
  final bool isValid;
  final String errMsg;
  final bool hidePw;

  PasswordFormState({
    @required this.password,
    @required this.isValid,
    @required this.errMsg,
    @required this.hidePw,
  }) : super([
          password,
          isValid,
          errMsg,
          hidePw,
        ]);

  factory PasswordFormState.initial() {
    return PasswordFormState(
      password: '',
      isValid: false,
      errMsg: '',
      hidePw: true,
    );
  }

  PasswordFormState copyWith({
    String password,
    bool isValid,
    String errMsg,
    bool hidePw,
  }) {
    return PasswordFormState(
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      errMsg: errMsg ?? this.errMsg,
      hidePw: hidePw ?? this.hidePw,
    );
  }
}

/* Bloc */

class PasswordBloc extends Bloc<PasswordFormEvent, PasswordFormState> {
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  @override
  PasswordFormState get initialState => PasswordFormState.initial();

  @override
  Stream<PasswordFormState> mapEventToState(PasswordFormEvent event) async* {
    if (event is PasswordChanged) {
      yield _handlePWChanged(event);
    }

    if (event is PasswordVisibilityChanged) {
      yield _handleVisChanged(event);
    }
  }

  PasswordFormState _handleVisChanged(PasswordVisibilityChanged event) {
    return currentState.copyWith(hidePw: !currentState.hidePw);
  }

  PasswordFormState _handlePWChanged(PasswordChanged event) {
    if (!_passwordRegExp.hasMatch(event.password)) {
      return currentState.copyWith(
        password: event.password,
        isValid: false,
        errMsg: 'Please enter a valid password',
      );
    } else {
      return currentState.copyWith(
        password: event.password,
        isValid: true,
        errMsg: null,
      );
    }
  }
}
