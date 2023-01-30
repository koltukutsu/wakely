import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "alarm_state.dart";

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit() : super(IdleState());

  undefined() async {
  }

}
