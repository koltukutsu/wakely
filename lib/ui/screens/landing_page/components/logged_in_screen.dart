import 'package:flutter/material.dart';
import 'package:wakely/ui/screens/landing_page/components/common_screen.dart';

class LoggedInScreen extends StatelessWidget {
  const LoggedInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String text = "";
    const String imagePath = '';
    const String buttonText = "";
    void buttonFunction() {

    }
    return LandingCommonScreen(text: text,
        imagePath: imagePath,
        buttonFunction: buttonFunction,
        buttonText: buttonText);
  }
}
