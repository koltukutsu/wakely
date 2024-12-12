import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/data/models/playlist_and_track_model.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/playlists_screen.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/sub_components/playingSong.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class IndividualAddedAlarm extends StatefulWidget {
  final IndividualAlarmModel alarmObject;

  const IndividualAddedAlarm({Key? key, required this.alarmObject})
      : super(key: key);

  @override
  State<IndividualAddedAlarm> createState() => _IndividualAddedAlarmState();
}

class _IndividualAddedAlarmState extends State<IndividualAddedAlarm> {
  bool paused = false;

  renderFunction() async {
    print("""userSongasdasdadsd""");

    final TrackSong userSong =
        context.read<SpotifyCubit>().userChoices.chosenTrack;
    setState(() {
      widget.alarmObject.songUrl = userSong.uri;
      widget.alarmObject.songImage = userSong.trackImage;
      widget.alarmObject.singerName = userSong.singer;
      widget.alarmObject.songTitle = userSong.trackName;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.alarmObject.songImage == "assets/images/placeholder.png") {
      return Container(
        width: MediaQuery.of(context).size.width * 0.835,
        height: MediaQuery.of(context).size.height * 0.152875,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.subPanel,
            border: Border.all(
              color: AppColors.borderColor,
              width: 0.3,
            )),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Image(
                  image: AssetImage("assets/images/placeholder.png"),
                  width: 81,
                  height: 81),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // author and alarm time
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(widget.alarmObject.alarmTime,
                        style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 32,
                            // fontFamily: "Inter",
                            fontWeight: FontWeight.w900)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: IconButton(
                          onPressed: () {
                            // TODO: shuffle a thing
                          },
                          icon: const Icon(Icons.shuffle_on_outlined,
                              color: AppColors.fontColor),
                          // color: AppColors.fontColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomButtonAnimated(
                            widthRatio: 0.35,
                            label: "Choose a Song!",
                            onPressed: () async {
                              // Navigator.of(context).push(createPageRoute(
                              //     pageRouteType:
                              //         PageRouteTypes.addAlarmToPlaylists));

                              // context.push("/alarms/add_alarm/playlists",
                              // extra: renderFunction);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => PlayListsScreen(
                                          renderFunction: renderFunction,
                                        )),
                              );

                              // await waitTheSong();
                              if (!mounted) return;
                              print("cikti");
                              // if(!mounted) return;
                            }),
                      ),
                    ],
                  ),
                  // title
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width * 0.835,
        height: MediaQuery.of(context).size.height * 0.152875,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.subPanel,
            border: Border.all(
              color: AppColors.borderColor,
              width: 0.3,
            )),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                onTap: () {
                  final TrackSong playingSong =
                      context.read<SpotifyCubit>().playingSong;

                  if ((paused == false) ||
                      (paused == true &&
                          playingSong.uri != widget.alarmObject.songUrl)) {
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
                child: Image(
                    image: NetworkImage(widget.alarmObject.songImage),
                    width: 81,
                    height: 81),
              ),
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
      );
    }
  }

  // void someListener() {
  //   if (!GoRouter.of(context).location.contains("/track")) {
  //     // Here you check for some changes in your route that indicate you are no longer on the page you have pushed before
  //     // final TrackSong userSong =
  //     //     context.read<SpotifyCubit>().userChoices.chosenTrack;
  //     // setState(() {
  //     //   widget.alarmObject.songUrl = userSong.uri;
  //     //   widget.alarmObject.songImage = userSong.trackImage;
  //     //   widget.alarmObject.singerName = userSong.singer;
  //     //   widget.alarmObject.songTitle = userSong.trackName;
  //     // });
  //     GoRouter.of(context).removeListener(someListener); // remove listener
  //   }
  // }
}
