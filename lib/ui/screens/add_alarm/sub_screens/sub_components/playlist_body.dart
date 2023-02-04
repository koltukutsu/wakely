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
import 'package:wakely/ui/screens/alarm/components/alarm_individual_widget.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class PlaylistBody extends StatefulWidget {
  const PlaylistBody({Key? key}) : super(key: key);
  @override
  State<PlaylistBody> createState() => _PlaylistBodyState();
}

class _PlaylistBodyState extends State<PlaylistBody> {
  bool isEnabled = true;
  int value = 0;
  bool positive = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            margin: const EdgeInsets.only(top: 12, right: 12, left: 12),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                // boxShadow: const [
                //   BoxShadow(
                //     color: AppColors.eerieBlack,
                //     spreadRadius: 2.0,
                //     blurRadius: 1,
                //     offset: Offset(1, 1.5), // changes position of shadow
                //   ),
                // ],
                borderRadius: BorderRadius.circular(20),
                color: AppColors.alarmGroupCardColor,
                border: Border.all(
                  color: AppColors.eerieBlack,
                  width: 0.3,
                )),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: CustomButtonAnimated(
                          label: "Okay, let's Go",
                          onPressed: () async {
                            // if (!mounted) return;
                            // Navigator.of(context).push(createPageRoute(
                            //     pageRouteType:
                            //         PageRouteTypes.playliststoTracks));
                            context.push("/alarms/add_alarm/playlists/tracks");

                            // if (alarmSet.alarms.isNotEmpty) {
                            //   alarmSet.groupName = _controller.text;
                            //   await context
                            //       .read<AlarmCubit>()
                            //       .setNewAlarmGroup(newAlarmGroup: alarmSet);
                            //   if (!mounted) return;
                            //   await context.read<AlarmCubit>().setAlarmGroups();
                            //   if (!mounted) return;
                            //   await context.read<AlarmCubit>().getAlarmGroups();
                            // } else {}
                          },
                          widthRatio: 0.4),
                    )
                  ],
                ),
                // const Padding(
                //   padding: EdgeInsets.only(right: 8.0, left: 8),
                //   child: Divider(color: AppColors.eerieBlack, thickness: 1.2),
                // ),
                const SizedBox(
                  height: 12,
                ),
                ...context
                    .read<SpotifyCubit>()
                    .userPlaylists
                    .map((Playlist userPlaylist) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child:
                              IndividualPlaylist(playListObject: userPlaylist),
                        )),
                const SizedBox(
                  height: 8,
                )
                // ...List.generate(widget.alarmSet.map, (index) => null)
              ],
            )),
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return ([
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
        ]);
      },
    );
  }
}
