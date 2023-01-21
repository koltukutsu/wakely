import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [ // remove const, fill purposes
        // BlocProvider(
        //     create: (context) =>
        //         Cubit(Repository())),
      ],
      child: const Center(), // fill
      // child: BlocBuilder
      // <ThemeCubit, ThemeData>(
      //   builder: (context, theme) => MaterialApp(
      //     theme: darkTheme,
      //     themeMode: ThemeMode.system,
      //     debugShowCheckedModeBanner: false,
      //     initialRoute: ROUTE_LOGIN,
      //     routes: {
      //       ROUTE_FIRST: (context) => const FirstScreen(),
      //       ROUTE_SECOND: (context) => const SecondScreen(),
      //     },
      //   ),
      // ),
    );
  }
}
