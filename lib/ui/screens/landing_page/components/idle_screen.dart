import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/ui/constants/constants.dart';
import 'package:wakely/ui/screens/landing_page/components/common_screen.dart';

class IdleScreen extends StatefulWidget {
  const IdleScreen({Key? key}) : super(key: key);

  @override
  State<IdleScreen> createState() => _IdleScreenState();
}

class _IdleScreenState extends State<IdleScreen> {
  @override
  Widget build(BuildContext context) {
    const String text =
        "In order to be able to use Wakely, you are supposed to have a Premium Spotify account. So, you gotta sign in your Spotify Account my little fella!!!";
    const String imagePath = 'assets/images/background.png';
    const String buttonText = "Okay, Let's Sign in!";
    void buttonFunction() async {
      AudioPlayer().play(AssetSource(AppPaths.buttonClickSound));
      await context.read<SpotifyCubit>().connectToSpotifyAccount();
      if (!mounted) return;
      await context.read<SpotifyCubit>().getAccessToken();
    }

    return LandingCommonScreen(
        text: text,
        imagePath: imagePath,
        buttonFunction: buttonFunction,
        buttonText: buttonText);
  }
}
