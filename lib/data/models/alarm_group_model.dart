import 'package:wakely/data/models/individual_alarm_model.dart';

class AlarmGroupModel {
  String groupName;
  final String id;
  final List<IndividualAlarmModel> alarms;

  AlarmGroupModel(
      {required this.groupName, required this.id, required this.alarms});

  // String toJsonString() {
  //   List<String> alarmsAsList = [];
  //   for (IndividualAlarmModel alarm in alarms) {
  //     final String alarmAsString = jsonEncode(alarm.toJsonObject());
  //     alarmsAsList.add(alarmAsString);
  //   }
  //
  //   return '{"groupName":$groupName, "id":$id, "alarms": $alarmsAsList}';
  // }

  Map<String, dynamic> toJsonObject() {
    return {
      'id': id,
      'groupName': groupName,
      'alarms': alarms
          .map((IndividualAlarmModel alarm) => alarm.toJsonObject())
          .toList(),
    };
  }

  AlarmGroupModel.fromJsonObject(Map<String, dynamic> json)
      : id = json['id'],
        groupName = json["groupName"],
        alarms = (json["alarms"])
            .map((dynamic alarmDynamic) {
              Map<String, dynamic> give = alarmDynamic;
              IndividualAlarmModel taken =
                  IndividualAlarmModel.fromJsonObject(give);
              return taken;
            })
            .toList()
            .cast<IndividualAlarmModel>();
}
