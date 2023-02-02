part of "alarm_cubit.dart";


abstract class AlarmState extends Equatable {
  const AlarmState();

  @override
  List<Object> get props => [];
}

class AlarmIdleState extends AlarmState {
  @override
  List<Object> get props => [];
}

class GotAlarms extends AlarmState {
  @override
  List<Object> get props => [];
}
