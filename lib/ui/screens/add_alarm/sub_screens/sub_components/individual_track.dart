import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/data/models/playlist_and_track_model.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/sub_components/playingSong.dart';
import 'package:wakely/ui/theme/colors.dart';

class IndividualTrack extends StatefulWidget {
  final TrackSong trackObject;
  final int index;
  final VoidCallback renderFunction;
  final Function({required int userChosenTrack}) chosenFunction;
  final bool chosen;

  const IndividualTrack(
      {Key? key,
      required this.chosen,
      required this.chosenFunction,
      required this.trackObject,
      required this.index,
      required this.renderFunction})
      : super(key: key);

  @override
  State<IndividualTrack> createState() => _IndividualTrackState();
}

class _IndividualTrackState extends State<IndividualTrack> {
  bool paused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.chosen == false) {
          print("Chosen track");
          widget.chosenFunction(userChosenTrack: (widget.index - 1));
          context
              .read<SpotifyCubit>()
              .setUserTrack(trackObject: widget.trackObject);
        } else {
          widget.chosenFunction(userChosenTrack: -1);
          context.read<SpotifyCubit>().resetUserChoices();
        }
        widget.renderFunction();
      },
      child: Card(
        color: widget.chosen ? AppColors.subPanel1 : AppColors.subPanel,
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                final TrackSong playingSong =
                    context.read<SpotifyCubit>().playingSong;

                if ((paused == false) ||
                    (paused == true &&
                        playingSong.uri != widget.trackObject.uri)) {
                  if (playingSong.uri == widget.trackObject.uri) {
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
                      builder: (context) =>
                          PlayingSongCard(trackObject: widget.trackObject),
                    );

                    context
                        .read<SpotifyCubit>()
                        .playTheSong(song: widget.trackObject);
                    setState(() {
                      paused = false;
                    });
                  }
                } else {
                  if (playingSong.uri == widget.trackObject.uri) {
                    print("Resume the song");
                    showCupertinoModalBottomSheet(
                      context: context,
                      expand: false,
                      builder: (context) =>
                          PlayingSongCard(trackObject: widget.trackObject),
                    );
                    context.read<SpotifyCubit>().resumeTheSong();
                    setState(() {
                      paused = false;
                    });
                  }
                }
              },
              child: SizedBox(
                height: 90.0,
                width: 90.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    if (widget.trackObject.trackImage !=
                        "assets/images/placeholder.png")
                      Image.network(
                        widget.trackObject.trackImage,
                        fit: BoxFit.cover,
                      )
                    else
                      Image.asset(
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
