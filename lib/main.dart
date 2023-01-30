import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ui/screens/alarm/main_screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const AlarmScreen());
}