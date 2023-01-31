import 'package:flutter/material.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/screens/alarm/components/alarm_widget.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/ui/theme/colors.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.seaFoamOriginalGreen,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(createPageRoute(
                      pageRouteType: PageRouteTypes.alarmMainToAddAlarm));
                },
                icon: const Icon(
                  Icons.add,
                  color: AppColors.eerieBlack,
                ),
                color: AppColors.tropicalViolet,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.eerieBlack,
                ),
                color: AppColors.tropicalViolet,
              ),
            ],
            pinned: false,
            snap: false,
            floating: false,
            expandedHeight: 80.0,
            backgroundColor: AppColors.seaFoamOriginalGreen,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                'Welcome!',
                style: TextStyle(
                  color: AppColors.eerieBlack,
                ),
              ),
              collapseMode: CollapseMode.parallax,
              // background: AppColors.mainBackgroundColor,
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
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
          ]))
        ],
      ),
    );
  }
}
