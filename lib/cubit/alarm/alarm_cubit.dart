import 'dart:convert';
import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:wakely/data/models/alarm_group_model.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';

part "alarm_state.dart";

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit() : super(AlarmIdleState());
  List<AlarmGroupModel> alarmGroups = [];
  int counter = 1;

  undefined() async {}

  saveAlarmGroup() {}

  setAlarmGroups() async {
    // Create a box collection
    // Obtain shared preferences.
    if (alarmGroups.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      List<String> finalPut = [];
      for (AlarmGroupModel alarmGroup in alarmGroups) {
        final String finalPutString = jsonEncode(alarmGroup.toJsonObject());
        finalPut.add(finalPutString);
      }
      await prefs.setStringList("alarm_groups", finalPut);
    }

    print("Setted again!: ${alarmGroups.length}");
  }

  getAlarmGroups() async {
    emit(AlarmIdleState());
    final prefs = await SharedPreferences.getInstance();
    final List<String>? alarmGroupsAsList = prefs.getStringList("alarm_groups");
    print(alarmGroupsAsList);
    print("LOLOLOLOLO");
    if (alarmGroupsAsList != null) {
      final List<AlarmGroupModel> takenAlarmGroups =
          alarmGroupsAsList.map((String alarmGroupAsString) {
        Map<String, dynamic> alarmGroupAsJson = jsonDecode(alarmGroupAsString);
        return AlarmGroupModel.fromJsonObject(alarmGroupAsJson);
      }).toList();
      alarmGroups = takenAlarmGroups.cast<AlarmGroupModel>();
      emit(GotAlarms());
      print("Get: ${alarmGroups.length}");
    } else {
      emit(ZeroGotAlarms());
    }
  }

  setNewAlarmGroup({required AlarmGroupModel newAlarmGroup}) async {
    alarmGroups = [...alarmGroups, newAlarmGroup];
    print("New: ${alarmGroups.length}");
  }

  void deleteAlarmGroup({required AlarmGroupModel alarmGroupObject}) {
    alarmGroups.removeWhere(
        (alarmGObject) => (alarmGObject.id == alarmGroupObject.id));
    setAlarmGroups();
  }
  @pragma('vm:entry-point')
  activateAlarm({required AlarmGroupModel alarmGroup}) {
    for (IndividualAlarmModel alarm in alarmGroup.alarms) {
      print(alarm.alarmTime);
      // AndroidAlarmManager.periodic(duration, id, callback);
    }
  }

  @pragma('vm:entry-point')
  deactivateAlarm({required AlarmGroupModel alarmGroup}) {
    for (IndividualAlarmModel alarm in alarmGroup.alarms) {
      // AndroidAlarmManager.cancel(id);
    }
  }
}
