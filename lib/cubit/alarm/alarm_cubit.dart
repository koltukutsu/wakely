import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:wakely/data/models/alarm_group_model.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';

part "alarm_state.dart";

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit() : super(AlarmIdleState());
  var alarmGroups;

  undefined() async {}

  saveAlarmGroup() {}

  setAlarmGroups() async {
    // Create a box collection
    List<AlarmGroupModel> alarmGroupTry = [
      AlarmGroupModel(
        groupName: "Waking Up",
        id: Uuid().v1(),
        alarms: <IndividualAlarmModel>[
          IndividualAlarmModel(
              alarmTime: "03:35",
              songTitle: "There Is A Light That Never Goes Out",
              songBackgroundColor: const Color(0xFF304038),
              songImage: "songs/there_is_a_light.png",
              singerName: "The Smiths"),
          IndividualAlarmModel(
              alarmTime: "03:40",
              songTitle: "This Charming Man - 2011 Remastered",
              songBackgroundColor: const Color(0xFF502030),
              songImage: "songs/this_charming_man.png",
              singerName: "The Smiths"),
          IndividualAlarmModel(
              alarmTime: "04:45",
              songTitle: "Heaven Knows I'm miserable tonight",
              songBackgroundColor: const Color(0xFF4A79AF),
              songImage: "songs/heaven_knows.png",
              singerName: "The Smiths"),
        ],
      ),
      AlarmGroupModel(
          groupName: "Nap",
          id: Uuid().v1().toString(),
          alarms: <IndividualAlarmModel>[
            IndividualAlarmModel(
                alarmTime: "13:30",
                songTitle: "No Heart To Speak Of",
                songBackgroundColor: const Color(0xFFAC6432),
                songImage: "songs/no_heart_to_speak_of.png",
                singerName: "QuietDrive"),
            IndividualAlarmModel(
                alarmTime: "13:35",
                songTitle: "Más Y Más",
                songBackgroundColor: const Color(0xFFC82828),
                songImage: "songs/mas_y_mas.png",
                singerName: "The Smiths"),
          ])
    ];
  }
}
