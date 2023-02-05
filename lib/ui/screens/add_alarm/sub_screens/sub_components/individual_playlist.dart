import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/data/models/playlist_and_track_model.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/theme/colors.dart';

class IndividualPlaylist extends StatefulWidget {
  final Playlist playListObject;
  final int index;
  final VoidCallback renderFunction;

  const IndividualPlaylist(
      {Key? key, required this.playListObject, required this.index, required this.renderFunction})
      : super(key: key);

  @override
  State<IndividualPlaylist> createState() => _IndividualPlaylistState();
}

class _IndividualPlaylistState extends State<IndividualPlaylist> {
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Chosen playlist");
        context
            .read<SpotifyCubit>()
            .setUserPlaylist(playlistObject: widget.playListObject);
        print(enabled);
        setState(() {
          enabled = !enabled;
        });
        print(enabled);
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
                  if(widget.playListObject.playListImage != "assets/images/placeholder.png")
                    Image.network(
                      widget.playListObject.playListImage,
                      fit: BoxFit.cover,
                    ) else const Image(

                    image: AssetImage("assets/images/no_playlist.png"),
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
                child: Text(
                  widget.playListObject.playListName,
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


// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wakely/cubit/spotify/spotify_cubit.dart';
// import 'package:wakely/data/models/individual_alarm_model.dart';
// import 'package:wakely/data/models/playlist_and_track_model.dart';
// import 'package:wakely/ui/theme/colors.dart';
//
// class IndividualPlaylist extends StatefulWidget {
//   final Playlist playListObject;
//
//   const IndividualPlaylist({Key? key, required this.playListObject})
//       : super(key: key);
//
//   @override
//   State<IndividualPlaylist> createState() => _IndividualPlaylistState();
// }
//
// class _IndividualPlaylistState extends State<IndividualPlaylist> {
//   bool chosen = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         print("Chosen playlist");
//         context
//             .read<SpotifyCubit>()
//             .setUserPlaylist(playlistObject: widget.playListObject);
//         setState(() {
//           chosen = !chosen;
//         });
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.835,
//         height: MediaQuery.of(context).size.height * 0.152875,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: chosen ? AppColors.subPanel1 : AppColors.mainBackgroundColor,
//             border: Border.all(
//               color: AppColors.eerieBlack,
//               width: 0.3,
//             )),
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: widget.playListObject.playListImage != "-"
//                   ? Image(
//                       image: NetworkImage(widget.playListObject.playListImage),
//                       width: 81,
//                       height: 81)
//                   : const Image(
//                       image: AssetImage("assets/images/placeholder.png"),
//                       width: 81,
//                       height: 81),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Text(widget.playListObject.playListName,
//                   // alarmObject.songTitle.length > 15
//                   //     ? '${alarmObject.songTitle.substring(0, 15)}...'
//                   //     : alarmObject.songTitle,
//                   style: const TextStyle(
//                       color: AppColors.fontColor,
//                       fontSize: 20,
//                       // fontFamily: "Inter",
//                       fontWeight: FontWeight.w400)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
