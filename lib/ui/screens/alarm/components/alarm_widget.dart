import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/alarm/alarm_cubit.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/alarm_group_model.dart';
import 'package:wakely/ui/screens/add_alarm/components/time_picker.dart';
import 'package:wakely/ui/screens/alarm/components/alarm_individual_widget.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class AlarmGroupWidget extends StatefulWidget {
  final AlarmGroupModel alarmGroup;
  final VoidCallback functionRender;

  const AlarmGroupWidget(
      {Key? key, required this.alarmGroup, required this.functionRender})
      : super(key: key);

  @override
  State<AlarmGroupWidget> createState() => _AlarmGroupWidgetState();
}

class _AlarmGroupWidgetState extends State<AlarmGroupWidget> {
  bool isEnabled = true;
  int value = 0;
  bool positive = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.only(top: 12, right: 12, left: 12),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            // boxShadow: const [
            //   BoxShadow(
            //     color: AppColors.eerieBlack,
            //     spreadRadius: 2.0,
            //     blurRadius: 1,
            //     offset: Offset(1, 1.5), // changes position of shadow
            //   ),
            // ],
            borderRadius: BorderRadius.circular(20),
            color: AppColors.panel,
            border: Border.all(
              color: AppColors.borderColor,
              width: 0.3,
            )),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(widget.alarmGroup.groupName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.fontColor,
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, bottom: 6),
                      child: CustomButtonAnimated(
                          label: "Delete",
                          buttonColor: AppColors.deleteButton,
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                          'Do you want to delete the Alarm List?'),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              context
                                                  .read<AlarmCubit>()
                                                  .deleteAlarmGroup(
                                                      alarmGroupObject:
                                                          widget.alarmGroup);
                                              widget.functionRender();

                                              Navigator.pop(context);
                                            },
                                            child: const Text('Delete'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );

                            //
                          },
                          widthRatio: 0.2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Switch(
                        activeColor: AppColors.active,
                        inactiveThumbColor: AppColors.inactive,
                        trackColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return AppColors.eerieBlack;
                          }
                          return AppColors.eerieBlack;
                        }),
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return AppColors.eerieBlack;
                          }
                          return AppColors.eerieBlack;
                        }),
                        value: isEnabled,
                        onChanged: (bool value) {
                          if(value){
                            context.read<AlarmCubit>().activateAlarm(alarmGroup: widget.alarmGroup);
                          }else {
                            context.read<AlarmCubit>().deactivateAlarm(alarmGroup: widget.alarmGroup);

                          }
                          setState(() {
                            isEnabled = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            // const Padding(
            //   padding: EdgeInsets.only(right: 8.0, left: 8),
            //   child: Divider(color: AppColors.eerieBlack, thickness: 1.2),
            // ),
            const SizedBox(
              height: 8,
            ),
            ...widget.alarmGroup.alarms
                .map((IndividualAlarmModel alarmObject) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: IndividualAlarm(alarmObject: alarmObject),
                    )),
            const SizedBox(
              height: 8,
            )
            // ...List.generate(widget.alarmSet.map, (index) => null)
          ],
        ));
  }
}
