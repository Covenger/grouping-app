import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

@immutable
class NameFormState extends Equatable {
  final String name;
  final bool isValid;
  final String errMsg;

  NameFormState({
    @required this.name,
    @required this.isValid,
    @required this.errMsg,
  }) : super([
          name,
          isValid,
          errMsg,
        ]);

  factory NameFormState.initial() {
    return NameFormState(
      name: '',
      isValid: false,
      errMsg: '',
    );
  }
}

class NameBloc extends Bloc<String, NameFormState> {
  @override
  NameFormState get initialState => NameFormState.initial();

  @override
  Stream<NameFormState> mapEventToState(String name) async* {
    if (name.length < 2) {
      yield new NameFormState(name: name, isValid: false, errMsg: 'Too short');
    } else {
      // TODO: Confirm name duplication
      yield new NameFormState(name: name, isValid: true, errMsg: null);
    }
  }
}
