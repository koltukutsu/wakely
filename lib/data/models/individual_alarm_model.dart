import 'package:flutter/painting.dart';

class IndividualAlarmModel {
  final String alarmTime;

  // final String alarm;

  final String songTitle;
  final Color songBackgroundColor;
  final String songImage;
  final String singerName;

  IndividualAlarmModel(
      { required this.alarmTime,
      required this.songTitle,
      required this.songBackgroundColor,
      required this.songImage,
      required this.singerName});
}
