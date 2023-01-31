import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/ui/constants/constants.dart';
import 'package:wakely/ui/screens/landing_page/components/common_screen.dart';

class NotPremiumScreen extends StatelessWidget {
  const NotPremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String text = "";
    const String imagePath = 'assets/images/no_premium.png';
    const String buttonText = "Well :D";
    void buttonFunction() {
      AudioPlayer().play(AssetSource(AppPaths.buttonClickSound));
      context.read<SpotifyCubit>().emitIdleState();
    }

    return LandingCommonScreen(
        text: text,
        imagePath: imagePath,
        buttonFunction: buttonFunction,
        buttonText: buttonText);
  }
}
