// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:wakely/ui/screens/add_alarm/add_alarm_group_main.dart';
// import 'package:wakely/ui/screens/alarm/main_screen.dart';
// import 'package:wakely/ui/screens/add_alarm/sub_screens/playlists_screen.dart';
// import 'package:wakely/ui/screens/add_alarm/sub_screens/tracks_screen.dart';
// import 'package:wakely/ui/screens/landing_page/landing_page.dart';
//
// enum PageRouteTypes {
//   landingToAlarmMain,
//   alarmMainToAddAlarm,
//   addAlarmToPlaylists,
//   playliststoTracks,
//   tracksToAddAlarm,
//   addAlarmToAlarmMain,
// }
//
// Route createPageRoute({required PageRouteTypes pageRouteType}) {
//   if (pageRouteType == PageRouteTypes.landingToAlarmMain) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const AlarmScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(0.0, -1.0);
//         const end = Offset.zero;
//         const curve = Curves.ease;
//
//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   } else if (pageRouteType == PageRouteTypes.alarmMainToAddAlarm) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const AddAlarmScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0);
//         const end = Offset.zero;
//         const curve = Curves.ease;
//
//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   } else if (pageRouteType == PageRouteTypes.addAlarmToPlaylists) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const PlayListsScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0);
//         const end = Offset.zero;
//         const curve = Curves.ease;
//
//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   } else if (pageRouteType == PageRouteTypes.playliststoTracks) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const TracksScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(0.0, -1.0);
//         const end = Offset.zero;
//         const curve = Curves.ease;
//
//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   } else if (pageRouteType == PageRouteTypes.tracksToAddAlarm) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const AddAlarmScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(0.0, -1.0);
//         const end = Offset.zero;
//         const curve = Curves.ease;
//
//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   } else if (pageRouteType == PageRouteTypes.addAlarmToAlarmMain) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const AlarmScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(0.0, -1.0);
//         const end = Offset.zero;
//         const curve = Curves.ease;
//
//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   } else {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>
//           const AlarmScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(0.0, 1.0);
//         const end = Offset.zero;
//         const curve = Curves.ease;
//
//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   }
// }
