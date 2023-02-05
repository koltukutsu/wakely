import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:wakely/cubit/alarm/alarm_cubit.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/alarm_group_model.dart';
import 'package:wakely/data/models/playlist_and_track_model.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/sub_components/individual_playlist.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/sub_components/individual_track.dart';
import 'package:wakely/ui/screens/alarm/components/alarm_individual_widget.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class TrackBody extends StatefulWidget {
  final VoidCallback renderFunction;

  const TrackBody({Key? key, required this.renderFunction}) : super(key: key);

  @override
  State<TrackBody> createState() => _TrackBodyState();
}

class _TrackBodyState extends State<TrackBody> {
  int chosenTrack = -1;

  void setChosenTrack({required int userChosenTrack}) {
    setState(() {
      chosenTrack = userChosenTrack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final TrackSong track =
                  context.read<SpotifyCubit>().userTracksOfPlaylist[index];
              return IndividualTrack(
                  trackObject: track,
                  index: index + 1,
                  renderFunction: widget.renderFunction,
                  chosenFunction: setChosenTrack,
                  chosen: chosenTrack == index);
            },
            childCount:
                context.read<SpotifyCubit>().userTracksOfPlaylist.length,
          ),
        )
      ],
    );
  }
}
