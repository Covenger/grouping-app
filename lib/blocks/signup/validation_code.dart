import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/* Events */

@immutable
abstract class CodeValidationEvent extends Equatable {
  CodeValidationEvent([List props = const []]) : super(props);
}

class CodeChanged extends CodeValidationEvent {
  final String code;

  CodeChanged({@required this.code}) : super([code]);

  @override
  String toString() => 'CodeChanged { code: $code }';
}

class ResendCode extends CodeValidationEvent {}

/* State */

@immutable
class ValidationCodeFormState extends Equatable {
  final String code;
  final bool isValid;
  final String errMsg;

  ValidationCodeFormState({
    @required this.code,
    @required this.isValid,
    @required this.errMsg,
  }) : super([
          code,
          isValid,
          errMsg,
        ]);

  factory ValidationCodeFormState.initial() {
    return ValidationCodeFormState(
      code: '',
      isValid: false,
      errMsg: '',
    );
  }
}

/* Bloc */

class ValidationCodeBloc extends Bloc<CodeValidationEvent, ValidationCodeFormState> {
  @override
  ValidationCodeFormState get initialState => ValidationCodeFormState.initial();

  @override
  Stream<ValidationCodeFormState> mapEventToState(CodeValidationEvent event) async* {
    if (event is CodeChanged) {
      yield _handleChanged(event);
    }
    if (event is ResendCode) {
      yield _handleResend(event);
    }
  }

  ValidationCodeFormState _handleChanged(CodeChanged event) {
    if (event.code.length == 6) {
      return ValidationCodeFormState(code: event.code, isValid: true, errMsg: null);
    } else {
      return ValidationCodeFormState(code: event.code, isValid: false, errMsg: 'Please enter a valid code');
    }
  }

  ValidationCodeFormState _handleResend(ResendCode event) {
    // TODO
    return ValidationCodeFormState(code: null, isValid: false, errMsg: null);
  }
}
