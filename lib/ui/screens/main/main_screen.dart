import 'package:flutter/material.dart';
import 'package:wakely/ui/screens/main/components/alarm_individual_widget.dart';
import 'package:wakely/ui/screens/main/components/alarm_widget.dart';
import 'package:wakely/ui/screens/main/components/individual_alarm_model.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rizik App',
      theme: ThemeData(),
      home: Scaffold(
        backgroundColor: const Color(0xFFECF0F3),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AlarmGroupWidget(
                alarmGroupName: "Nap Time",
                alarmSet: <IndividualAlarmModel>[
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
                ]),
            AlarmGroupWidget(
                alarmGroupName: "Waking Up",
                alarmSet: <IndividualAlarmModel>[
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
                ])
          ],
        ),
      ),
    );
  }
}
