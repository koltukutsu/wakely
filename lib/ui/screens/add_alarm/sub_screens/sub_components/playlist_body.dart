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

class PlaylistBody extends StatefulWidget {
  // final VoidCallback renderFunction;
  final VoidCallback secondRenderFunction;

  const PlaylistBody({Key? key, required this.secondRenderFunction})
      : super(key: key);

  @override
  State<PlaylistBody> createState() => _PlaylistBody();
}

class _PlaylistBody extends State<PlaylistBody> {
  int chosenPlaylist = -1;

  void setChosenPlaylist({required int userChosenPlaylist}) {
    setState(() {
      chosenPlaylist = userChosenPlaylist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Playlist track =
                  context.read<SpotifyCubit>().userPlaylists[index];
              return IndividualPlaylist(
                playListObject: track,
                index: index + 1,
                renderFunction: widget.secondRenderFunction,
                chosenFunction: setChosenPlaylist,
                chosen: chosenPlaylist == index
              );
            },
            childCount: context.read<SpotifyCubit>().userPlaylists.length,
          ),
        )
      ],
    );
  }
}

