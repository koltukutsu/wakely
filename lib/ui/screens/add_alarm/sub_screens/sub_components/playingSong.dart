import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/data/models/playlist_and_track_model.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/theme/colors.dart';

class PlayingSongCard extends StatefulWidget {
  final TrackSong trackObject;

  const PlayingSongCard({
    Key? key,
    required this.trackObject,
  }) : super(key: key);

  @override
  State<PlayingSongCard> createState() => _PlayingSongCardState();
}

class _PlayingSongCardState extends State<PlayingSongCard> {
  bool paused = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.17,
          child: Column(
            children: [
              const Center(
                  child: Text(
                "Now Playing",
                style: TextStyle(fontSize: 24),
              )),
              Row(
                children: <Widget>[
                  SizedBox(
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
            ],
          ),
        ),
      ),
    );
  }
}
