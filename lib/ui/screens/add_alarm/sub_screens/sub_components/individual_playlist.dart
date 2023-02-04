import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/data/models/playlist_and_track_model.dart';
import 'package:wakely/ui/theme/colors.dart';

class IndividualPlaylist extends StatefulWidget {
  final Playlist playListObject;

  const IndividualPlaylist({Key? key, required this.playListObject})
      : super(key: key);

  @override
  State<IndividualPlaylist> createState() => _IndividualPlaylistState();
}

class _IndividualPlaylistState extends State<IndividualPlaylist> {
  bool chosen = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Chosen playlist");
        context
            .read<SpotifyCubit>()
            .setUserPlaylist(playlistObject: widget.playListObject);
        setState(() {
          chosen = !chosen;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.835,
        height: MediaQuery.of(context).size.height * 0.152875,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: chosen ? AppColors.subPanel1 : AppColors.mainBackgroundColor,
            border: Border.all(
              color: AppColors.eerieBlack,
              width: 0.3,
            )),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: widget.playListObject.playListImage != "-"
                  ? Image(
                      image: NetworkImage(widget.playListObject.playListImage),
                      width: 81,
                      height: 81)
                  : const Image(
                      image: AssetImage("assets/images/placeholder.png"),
                      width: 81,
                      height: 81),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.playListObject.playListName,
                  // alarmObject.songTitle.length > 15
                  //     ? '${alarmObject.songTitle.substring(0, 15)}...'
                  //     : alarmObject.songTitle,
                  style: const TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 20,
                      // fontFamily: "Inter",
                      fontWeight: FontWeight.w400)),
            )
          ],
        ),
      ),
    );
  }
}
