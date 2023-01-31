import 'package:wakely/data/models/individual_alarm_model.dart';

class AlarmGroupModel {
  final String groupName;
  final String id;
  final List<IndividualAlarmModel> alarms;

  AlarmGroupModel(
      {required this.groupName, required this.id, required this.alarms});
}
