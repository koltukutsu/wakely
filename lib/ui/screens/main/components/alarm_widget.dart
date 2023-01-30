import 'package:flutter/material.dart';
import 'package:wakely/ui/screens/main/components/alarm_individual_widget.dart';
import 'package:wakely/ui/screens/main/components/individual_alarm_model.dart';
import 'package:wakely/ui/theme/colors.dart';

class AlarmGroupWidget extends StatefulWidget {
  final String alarmGroupName;
  final List<IndividualAlarmModel> alarmSet;

  const AlarmGroupWidget(
      {Key? key, required this.alarmGroupName, required this.alarmSet})
      : super(key: key);

  @override
  State<AlarmGroupWidget> createState() => _AlarmGroupWidgetState();
}

class _AlarmGroupWidgetState extends State<AlarmGroupWidget> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.only(top: 12),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.alarmGroupCardColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(widget.alarmGroupName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.alarmGroupNameColor,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Switch(
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
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
            const Divider(),
            ...widget.alarmSet
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
