import 'package:flutter/material.dart';
import 'package:wakely/data/models/alarm_group_model.dart';
import 'package:wakely/ui/screens/alarm/components/alarm_individual_widget.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class AlarmGroupWidget extends StatefulWidget {
  final AlarmGroupModel alarmGroup;

  const AlarmGroupWidget({Key? key, required this.alarmGroup})
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
            color: AppColors.alarmGroupCardColor,
            border: Border.all(
              color: AppColors.eerieBlack,
              width: 1.5,
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
                        color: AppColors.alarmGroupNameColor,
                      )),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, bottom: 6),
                      child: CustomButtonAnimated(
                          label: "Delete",
                          buttonColor: AppColors.tropicalViolet,
                          onPressed: () async {
                            if (1 == 1) {
                              print("12313");
                            } else {}
                          },
                          widthRatio: 0.2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Switch(
                        activeColor: AppColors.seaFoamOriginalGreen,
                        inactiveThumbColor: AppColors.tropicalViolet,
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
