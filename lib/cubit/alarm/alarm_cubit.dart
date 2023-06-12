import 'dart:convert';
import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:wakely/data/models/alarm_group_model.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';

part "alarm_state.dart";

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit() : super(AlarmIdleState());
  List<AlarmGroupModel> alarmGroups = [];
  int counter = 1;
  late IndividualAlarmModel alarmObject;

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

  activateAlarm({required AlarmGroupModel alarmGroup}) async {
    for (IndividualAlarmModel alarm in alarmGroup.alarms) {
      alarmObject = alarm;
      final int hour = int.parse(alarm.alarmTime.split(":")[0]);
      final int minute = int.parse(alarm.alarmTime.split(":")[1]);
      print("$hour:$minute ${alarm.songTitle}");
      // continue;
      TimeOfDay alarmTime = TimeOfDay(hour: hour, minute: minute);
      DateTime now = DateTime.now();
      DateTime scheduledTime = DateTime(
          now.year, now.month, now.day, alarmTime.hour, alarmTime.minute);

      if (scheduledTime.isBefore(now)) {
        scheduledTime = scheduledTime.add(const Duration(days: 1));
      }
      counter+= 1;
      await AndroidAlarmManager.periodic(
        const Duration(days: 1), // Repeat interval (1 day)
        counter, // Alarm ID (use a unique value for different alarms)
        alarmCallback, // Callback function
        startAt: scheduledTime,
        // Set the initial trigger time
        exact: true,
        // Set it to true for alarms that need to be triggered at an exact time
        wakeup: true, // Set it to true to wake up the device if it's asleep
      );

    }
  }

  deactivateAlarm({required AlarmGroupModel alarmGroup}) {
    for (IndividualAlarmModel alarm in alarmGroup.alarms) {
      // AndroidAlarmManager.cancel(id);
    }
  }

  @pragma('vm:entry-point')
  void alarmCallback(){
    final DateTime now = DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    print("Setting the song ${alarmObject.songUrl}");
      try {
        SpotifySdk.play(spotifyUri: alarmObject.songUrl);
      } on PlatformException catch (e) {
        // setStatus(e.code, message: e.message);
        print("${e.code} + ${e.message}");
      } on MissingPluginException {
        print('not implemented');
      }
    print(
        "[$now] 33 Hello, world! isolate=${isolateId} function='$alarmCallback'");
  }
}
