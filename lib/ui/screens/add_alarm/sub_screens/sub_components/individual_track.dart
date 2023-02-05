import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/data/models/playlist_and_track_model.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/theme/colors.dart';

class IndividualTrack extends StatefulWidget {
  final TrackSong trackObject;
  final int index;
  final VoidCallback renderFunction;

  const IndividualTrack(
      {Key? key, required this.trackObject, required this.index, required this.renderFunction})
      : super(key: key);

  @override
  State<IndividualTrack> createState() => _IndividualTrackState();
}

class _IndividualTrackState extends State<IndividualTrack> {
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Chosen track");
        if(enabled) {
          context
              .read<SpotifyCubit>()
              .resetUserChoices();
        } else {
          context
              .read<SpotifyCubit>()
              .setUserTrack(trackObject: widget.trackObject);
        }

        widget.renderFunction();

        // context.read<SpotifyCubit>().updateTheSate(index: 0);
        // context.read<SpotifyCubit>().updateTheSate(index: 1);
        setState(() {
          enabled = !enabled;
        });
      },
      child: Card(
        color: enabled ? AppColors.subPanel1:AppColors.subPanel,
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 90.0,
              width: 90.0,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  if(widget.trackObject.trackImage != "assets/images/placeholder.png")
                  Image.network(
                    widget.trackObject.trackImage,
                    fit: BoxFit.cover,
                  ) else Image.asset(
                    widget.trackObject.trackImage,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(widget.index.toString()),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.trackObject.trackName,
                    ),
                    const SizedBox(height: 10.0),
                    Text(widget.trackObject.singer),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wakely/cubit/spotify/spotify_cubit.dart';
// import 'package:wakely/data/models/individual_alarm_model.dart';
// import 'package:wakely/data/models/playlist_and_track_model.dart';
// import 'package:wakely/ui/navigation/navigation_names.dart';
// import 'package:wakely/ui/theme/colors.dart';
//
// class IndividualTrack extends StatelessWidget {
//   final TrackSong trackObject;
//
//   const IndividualTrack({Key? key, required this.trackObject})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         print("Chosen track");
//         context.read<SpotifyCubit>().setUserTrack(trackObject: trackObject);
//
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.835,
//         height: MediaQuery.of(context).size.height * 0.152875,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: AppColors.mainBackgroundColor,
//             border: Border.all(
//               color: AppColors.eerieBlack,
//               width: 0.3,
//             )),
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: trackObject.trackImage != "-"
//                   ? Image(
//                   image: NetworkImage(trackObject.trackImage),
//                   width: 81,
//                   height: 81)
//                   : const Image(
//                   image: AssetImage("assets/images/placeholder.png"),
//                   width: 81,
//                   height: 81),
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // author and alarm time
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(trackObject.singer,
//                         style: const TextStyle(
//                             color: AppColors.fontColor,
//                             fontSize: 20,
//                             // fontFamily: "Inter",
//                             fontWeight: FontWeight.w300)),
//                   ),
//                   // title
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0),
//                     child: Text(trackObject.trackName,
//                         // alarmObject.songTitle.length > 15
//                         //     ? '${alarmObject.songTitle.substring(0, 15)}...'
//                         //     : alarmObject.songTitle,
//                         style: const TextStyle(
//                             color: AppColors.fontColor,
//                             fontSize: 24,
//                             // fontFamily: "Inter",
//                             fontWeight: FontWeight.w500)),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
