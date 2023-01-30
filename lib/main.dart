import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wakely/ui/main_app.dart';
import 'package:wakely/ui/screens/main/main_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const AlarmScreen());
}