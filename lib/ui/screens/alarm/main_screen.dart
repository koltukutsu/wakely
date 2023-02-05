import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wakely/cubit/alarm/alarm_cubit.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/alarm_group_model.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/screens/alarm/components/alarm_widget.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/ui/theme/colors.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<SpotifyCubit>().getTheFriends();
    context.read<SpotifyCubit>().getThePlayListsAndTheLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.userPanel,
                      border:
                          Border.all(color: AppColors.eerieBlack, width: 0.3)),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.push("/alarms/add_alarm");
                          // context.go("/alarms");
                          // Navigator.of(context).push(createPageRoute(
                          //     pageRouteType:
                          //         PageRouteTypes.alarmMainToAddAlarm));
                        },
                        highlightColor: AppColors.mainBackground,
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
                      // IconButton(
                      //   onPressed: () async {
                      //     await context.read<SpotifyCubit>().getTheUserProfile();
                      //   },
                      //   highlightColor: AppColors.mainBackgroundColor,
                      //   splashColor: AppColors.mainBackgroundColor,
                      //   icon: const Icon(
                      //     Icons.account_circle_outlined,
                      //     color: AppColors.eerieBlack,
                      //   ),
                      //   color: AppColors.tropicalViolet,
                      // ),
                    ],
                  ),
                ),
              ),
            ],
            pinned: false,
            snap: false,
            floating: false,
            expandedHeight: 80.0,
            backgroundColor: AppColors.mainBackground,
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
          BlocBuilder<AlarmCubit, AlarmState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state is GotAlarms) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    ...(context.read<AlarmCubit>().alarmGroups)
                        .map((AlarmGroupModel alarmGroup) => AlarmGroupWidget(
                              alarmGroup: alarmGroup,
                              functionRender: () {
                                setState(() {});
                              },
                            )),
                  ]));
                } else if (state is ZeroGotAlarms) {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const Center(
                          child: Text("No Alarms Yet"),
                        )
                      ],
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const CircularProgressIndicator(
                          color: AppColors.seaFoamOriginalGreen,
                        )
                      ],
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
