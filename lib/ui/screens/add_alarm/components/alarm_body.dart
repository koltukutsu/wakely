import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:wakely/cubit/alarm/alarm_cubit.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/alarm_group_model.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/screens/add_alarm/components/individual_added_alarm.dart';
import 'package:wakely/ui/screens/add_alarm/components/time_picker.dart';
import 'package:wakely/ui/screens/alarm/components/alarm_individual_widget.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class AlarmBody extends StatefulWidget {
  final AlarmGroupModel alarmSet;
  final TextEditingController controller;
  final VoidCallback selectTime;

  const AlarmBody(
      {Key? key,
      required this.controller,
      required this.alarmSet,
      required this.selectTime})
      : super(key: key);

  @override
  State<AlarmBody> createState() => _AlarmBodyState();
}

class _AlarmBodyState extends State<AlarmBody> {
  bool isEnabled = true;
  int value = 0;
  bool positive = false;
  bool loading = false;
  FocusNode alarmNameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        alarmNameFocus.unfocus();
      },
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
                padding: const EdgeInsets.only(top: 10),
                margin: const EdgeInsets.only(top: 12, right: 12, left: 12),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.alarmGroupCardColor,
                    border: Border.all(
                      color: AppColors.eerieBlack,
                      width: 0.3,
                    )),
                child: Column(
                  children: [
                    Center(
                      child: IconButton(
                        onPressed: () {
                          widget.selectTime();
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 8),
                      child: TextField(
                          onEditingComplete: () {
                            setState(() {
                              alarmNameFocus.unfocus();
                            });
                          },
                          maxLines: 1,
                          controller: widget.controller,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.alarmGroupNameColor,
                          ),
                          focusNode: alarmNameFocus,
                          autofocus: true,
                          decoration: const InputDecoration(
                              // prefixText: "Name of Your Alarm",
                              hintText: "Name of Your Alarm")),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ))
          ])),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: IndividualAddedAlarm(
                            alarmObject: widget.alarmSet.alarms[index]),
                      ),
                  childCount: widget.alarmSet.alarms.length))
        ],
      ),
    );
  }
}
