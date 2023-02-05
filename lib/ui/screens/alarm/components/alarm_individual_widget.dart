import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/data/models/playlist_and_track_model.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/sub_components/playingSong.dart';
import 'package:wakely/ui/theme/colors.dart';

class IndividualAlarm extends StatefulWidget {
  final IndividualAlarmModel alarmObject;

  const IndividualAlarm({Key? key, required this.alarmObject})
      : super(key: key);

  @override
  State<IndividualAlarm> createState() => _IndividualAlarmState();
}

class _IndividualAlarmState extends State<IndividualAlarm> {
  bool paused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final TrackSong playingSong = context.read<SpotifyCubit>().playingSong;

        if ((paused == false) ||
            (paused == true && playingSong.uri != widget.alarmObject.songUrl)) {
          if (playingSong.uri == widget.alarmObject.songUrl) {
            print("pause the song");
            context.read<SpotifyCubit>().pauseTheSong();
            setState(() {
              paused = true;
            });
          } else {
            print("Start the song");
            showCupertinoModalBottomSheet(
              context: context,
              expand: false,
              builder: (context) => PlayingSongCard(
                  trackObject: TrackSong(
                      trackImage: widget.alarmObject.songImage,
                      trackName: widget.alarmObject.songTitle,
                      uri: widget.alarmObject.songUrl,
                      singer: widget.alarmObject.singerName)),
            );
            context.read<SpotifyCubit>().playTheSong(
                song: TrackSong(
                    trackImage: widget.alarmObject.songImage,
                    trackName: widget.alarmObject.songTitle,
                    uri: widget.alarmObject.songUrl,
                    singer: widget.alarmObject.singerName));
            setState(() {
              paused = false;
            });
          }
        } else {
          if (playingSong.uri == widget.alarmObject.songUrl) {
            print("Resume the song");
            showCupertinoModalBottomSheet(
              context: context,
              expand: false,
              builder: (context) => PlayingSongCard(
                  trackObject: TrackSong(
                      trackImage: widget.alarmObject.songImage,
                      trackName: widget.alarmObject.songTitle,
                      uri: widget.alarmObject.songUrl,
                      singer: widget.alarmObject.singerName)),
            );
            context.read<SpotifyCubit>().resumeTheSong();
            setState(() {
              paused = false;
            });
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.835,
        height: MediaQuery.of(context).size.height * 0.152875,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.mainBackgroundColor,
            border: Border.all(
              color: AppColors.eerieBlack,
              width: 0.3,
            )),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: widget.alarmObject.songImage !=
                      "assets/images/placeholder.png"
                  ? Image(
                      image: NetworkImage(widget.alarmObject.songImage),
                      width: 81,
                      height: 81)
                  : const Image(
                      image: AssetImage("assets/images/placeholder.png"),
                      width: 81,
                      height: 81),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // author and alarm time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(widget.alarmObject.singerName,
                            style: const TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 20,
                                // fontFamily: "Inter",
                                fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(widget.alarmObject.alarmTime,
                            style: const TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 32,
                                // fontFamily: "Inter",
                                fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),
                  // title
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.alarmObject.songTitle,
                        // alarmObject.songTitle.length > 15
                        //     ? '${alarmObject.songTitle.substring(0, 15)}...'
                        //     : alarmObject.songTitle,
                        style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 24,
                            // fontFamily: "Inter",
                            fontWeight: FontWeight.w800)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
