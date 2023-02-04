import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wakely/cubit/alarm/alarm_cubit.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/screens/landing_page/components/idle_screen.dart';
import 'package:wakely/ui/screens/landing_page/components/not_logged_in_screen.dart';
import 'package:wakely/ui/screens/landing_page/components/not_premium_screen.dart';
import 'package:wakely/ui/theme/colors.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpotifyCubit, SpotifyState>(
      listenWhen: (context, state) {
        return state is! IdleState;
      },
      listener: (context, state) {
        if (state is LoggedIn) {
          // Navigate to next screen
          context.read<AlarmCubit>().getAlarmGroups();
          // Navigator.of(context).pushReplacement(createPageRoute(
          //     pageRouteType: PageRouteTypes.landingToAlarmMain));
          context.go("/alarms");
        }
        // else if (state is NotLoggedIn) {
        //   Navigator.of(context).push(createPageRoute(
        //       pageRouteType: PageRouteTypes.landingToAlarmMain));
        // } else if (state is NotPremium) {
        //   Navigator.of(context).push(createPageRoute(
        //       pageRouteType: PageRouteTypes.landingToAlarmMain));
        // }
      },
      buildWhen: (context, state) {
        return state is IdleState ||
            state is SpotifyDataLoading ||
            state is LoggedIn ||
            state is NotPremium ||
            state is NotLoggedIn;
      },
      builder: (context, state) {
        if (state is NotLoggedIn) {
          return const NotLoggedInScreen();
        }
        if (state is SpotifyDataLoading) {
          return const CircularProgressIndicator(
            color: AppColors.mainBackgroundColor,
            backgroundColor: AppColors.seaFoamOriginalGreen,
          );
        } else if (state is NotPremium) {
          return const NotPremiumScreen();
        } else {
          return const IdleScreen();
        }
      },
    );
  }
}
