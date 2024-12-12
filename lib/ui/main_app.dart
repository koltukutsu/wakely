import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wakely/cubit/alarm/alarm_cubit.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/ui/screens/add_alarm/add_alarm_group_main.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/playlists_screen.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/tracks_screen.dart';
import 'package:wakely/ui/screens/alarm/main_screen.dart';

import 'screens/landing_page/landing_page.dart';
import 'theme/colors.dart';

/// The route configuration.
final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LandingPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'alarms',
          builder: (BuildContext context, GoRouterState state) {
            return const AlarmScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'add_alarm',
              builder: (BuildContext context, GoRouterState state) {
                return const AddAlarmScreen();
              },
              routes: <RouteBase>[
                GoRoute(
                    path: 'playlists',
                    builder: (BuildContext context, GoRouterState state) {
                      return PlayListsScreen(
                        renderFunction: () {},
                      );
                    },
                    routes: <RouteBase>[
                      GoRoute(
                          path: 'tracks',
                          builder: (BuildContext context, GoRouterState state) {
                            return TracksScreen(
                              renderFunction: () {},
                            );
                          })
                    ]),
              ],
            ),
          ],
        )
      ])
]);

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
      child: GlobalLoaderOverlay(
        child: MaterialApp.router(
          themeMode: ThemeMode.system,

          title: "Wakely",
          // theme: ThemeData(fontFamily: 'BrandonText',backgroundColor: AppColors.mainBackgroundColor),
          theme: _buildShrineTheme(),
          debugShowCheckedModeBanner: false,
          // home: const LandingPage(),
          routerConfig: _router,
        ),
      ),
    );
  }
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    // toggleableActiveColor: shrinePink400,
    // accentColor: shrineBrown900,
    primaryColor: shrinePink100,
    // buttonColor: shrinePink100,
    scaffoldBackgroundColor: AppColors.mainBackground,
    cardColor: shrineBackgroundWhite,
    textSelectionTheme:
        const TextSelectionThemeData(selectionColor: shrinePink100),
    // textSelectionColor: shrinePink100,
    // errorColor: shrineErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    // accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
          // caption: base.caption?.copyWith(
          //   fontWeight: FontWeight.w400,
          //   fontSize: 14,
          //   letterSpacing: defaultLetterSpacing,
          // ),
          // button: base.button?.copyWith(
          //   fontWeight: FontWeight.w500,
          //   fontSize: 14,
          //   letterSpacing: defaultLetterSpacing,
          // ),
          )
      .apply(
        fontFamily: 'BrandonText',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink400,
  // primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  // secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
