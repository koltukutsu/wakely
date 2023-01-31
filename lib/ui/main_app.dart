import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/alarm/alarm_cubit.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';

import 'screens/landing_page/landing_page.dart';
import 'theme/colors.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // remove const, fill purposes
        BlocProvider(create: (context) => AlarmCubit()),
        BlocProvider(create: (context) => SpotifyCubit()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        title: "Wakely",
        theme: ThemeData(fontFamily: 'BrandonText',backgroundColor: AppColors.mainBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: const LandingPage(),
      ),
    );
  }
}
