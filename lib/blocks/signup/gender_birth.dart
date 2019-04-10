import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

enum Gender { Male, Female }

/* Events */

@immutable
abstract class GenderBirthFormEvent extends Equatable {
  GenderBirthFormEvent([List props = const []]) : super(props);
}

class GenderChanged extends GenderBirthFormEvent {
  final Gender gender;

  GenderChanged({@required this.gender}) : super([gender]);

  @override
  String toString() => 'GenderChanged { gender: $gender }';
}

class BirthdayChanged extends GenderBirthFormEvent {
  final DateTime birthDay;

  BirthdayChanged({@required this.birthDay}) : super([birthDay]);

  @override
  String toString() => 'BirthdayChanged { birthDay: $birthDay }';
}

/* State */

@immutable
class GenderBirthFormState extends Equatable {
  final Gender gender;
  final DateTime birthDay;
  final bool isGenderValid;
  final bool isBirthValid;
  final String errMsg;

  bool get isValid => isGenderValid && isBirthValid;

  GenderBirthFormState({
    @required this.gender,
    @required this.birthDay,
    @required this.isGenderValid,
    @required this.isBirthValid,
    @required this.errMsg,
  }) : super([
          gender,
          birthDay,
          isGenderValid,
          isBirthValid,
          errMsg,
        ]);

  factory GenderBirthFormState.initial() {
    return GenderBirthFormState(
      gender: Gender.Male,
      isGenderValid: true,
      birthDay: null,
      isBirthValid: false,
      errMsg: '',
    );
  }

  GenderBirthFormState copyWith({
    Gender gender,
    DateTime birthDay,
    bool isGenderValid,
    bool isBirthValid,
    String errMsg,
  }) {
    return GenderBirthFormState(
      gender: gender ?? this.gender,
      birthDay: birthDay ?? this.birthDay,
      isGenderValid: isGenderValid ?? this.isGenderValid,
      isBirthValid: isBirthValid ?? this.isBirthValid,
      errMsg: errMsg ?? this.errMsg,
    );
  }
}

/* Bloc */

class GenderBirthBloc extends Bloc<GenderBirthFormEvent, GenderBirthFormState> {
  @override
  GenderBirthFormState get initialState => GenderBirthFormState.initial();

  @override
  Stream<GenderBirthFormState> mapEventToState(GenderBirthFormEvent event) async* {
    if (event is GenderChanged) {
      yield _handleGenderChanged(event);
    }

    if (event is BirthdayChanged) {
      yield _handleBirthChanged(event);
    }
  }

  GenderBirthFormState _handleGenderChanged(GenderChanged event) {
    return currentState.copyWith(gender: event.gender, isGenderValid: true);
  }

  GenderBirthFormState _handleBirthChanged(BirthdayChanged event) {
    if (event.birthDay == null) {
      if (currentState.birthDay == null) {
        return currentState.copyWith(birthDay: null, isBirthValid: false);
      } else {
        return currentState.copyWith(birthDay: currentState.birthDay, isBirthValid: true);
      }
    } else {
      return currentState.copyWith(birthDay: event.birthDay, isBirthValid: true);
    }
  }
}
