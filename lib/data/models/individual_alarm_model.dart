import 'package:flutter/painting.dart';
import 'package:wakely/ui/theme/colors.dart';

class IndividualAlarmModel {
  String alarmTime;
  String songTitle;
  String songImage;
  String singerName;
  String songUrl;

  IndividualAlarmModel(
      {required this.alarmTime,
      required this.songTitle,
        required this.songImage,
        required this.songUrl,

      required this.singerName});

  String toJsonString() {
    return '{"alarmTime": $alarmTime, "songTitle": $songTitle, "songImage": $songImage, "singerName": $singerName, "songUrl":$songUrl}';
  }

  Map<String, dynamic> toJsonObject() {
    return {
      'alarmTime': alarmTime,
      'songTitle': songTitle,
      'songImage': songImage,
      'singerName': singerName,
      'songUrl': songUrl,
    };
  }

  IndividualAlarmModel.fromJsonObject(Map<String, dynamic> json)
      : alarmTime = json['alarmTime'],
        songTitle = json['songTitle'],
        songImage = json['songImage'],
        songUrl = json['songUrl'],
        singerName = json['singerName'];
}
