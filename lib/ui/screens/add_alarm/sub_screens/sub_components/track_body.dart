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
  bool isEnabled = true;
  int value = 0;
  bool positive = false;
  bool loading = false;
  bool chosen = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.mainBackgroundColor,
                    border:
                        Border.all(color: AppColors.eerieBlack, width: 0.3)),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        // context.go("/alarms/add_alarm");
                      },
                      highlightColor: AppColors.mainBackgroundColor,
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.eerieBlack,
                      ),
                      color: AppColors.tropicalViolet,
                    ),
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(context
                              .read<SpotifyCubit>()
                              .userProfile
                              .userImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25.0),
                          onTap: () {
                            // Navigator.of(context).push(createPageRoute(
                            //     pageRouteType:
                            //     PageRouteTypes.));
                            // TODO: add profile page
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
          pinned: false,
          snap: false,
          floating: false,
          expandedHeight: 80.0,
          backgroundColor: AppColors.seaFoamOriginalGreen,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text(
              'Welcome!',
              style: TextStyle(
                color: AppColors.eerieBlack,
              ),
            ),
            collapseMode: CollapseMode.parallax,
            // background: AppColors.mainBackgroundColor,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final TrackSong track =
                  context.read<SpotifyCubit>().userTracksOfPlaylist[index];
              return IndividualTrack(trackObject: track, index: index,renderFunction: widget.renderFunction,);
            },
            childCount:
                context.read<SpotifyCubit>().userTracksOfPlaylist.length,
          ),
        )
      ],
    );
  }
}
