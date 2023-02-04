import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:wakely/cubit/alarm/alarm_cubit.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/alarm_group_model.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
import 'package:wakely/ui/screens/add_alarm/components/individual_added_alarm.dart';
import 'package:wakely/ui/screens/add_alarm/components/time_picker.dart';
import 'package:wakely/ui/screens/alarm/components/alarm_individual_widget.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class AlarmBody extends StatefulWidget {
  const AlarmBody({Key? key}) : super(key: key);

  @override
  State<AlarmBody> createState() => _AlarmBodyState();
}

class _AlarmBodyState extends State<AlarmBody> {
  bool isEnabled = true;
  int value = 0;
  bool positive = false;
  bool loading = false;
  final TextEditingController _controller = TextEditingController();
  AlarmGroupModel alarmSet = AlarmGroupModel(
      groupName: "", id: const Uuid().v1(), alarms: <IndividualAlarmModel>[]);

  final TimeOfDay _time = const TimeOfDay(hour: 4, minute: 30);

  void _selectTime() async {
    // print(context
    //     .read<SpotifyCubit>()
    //     .userPlaylists);
    context.read<SpotifyCubit>().resetUserChoices();
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      final String hour =
          newTime.hour < 10 ? "0${newTime.hour}" : newTime.hour.toString();
      final String minute = newTime.minute < 10
          ? "0${newTime.minute}"
          : newTime.minute.toString();
      setState(() {
        alarmSet.alarms.add(IndividualAlarmModel(
            songUrl: "-",
            alarmTime: "$hour:$minute",
            songTitle: "-",
            songImage: "assets/images/placeholder.png",
            singerName: "-"));
      });
    }
  }

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
                Center(
                  child: IconButton(
                    onPressed: () {
                      _selectTime();
                      // setState(() {
                      //   alarmSet.alarms.add(IndividualAlarmModel(
                      //       songUrl: "1",
                      //       alarmTime: "04:45",
                      //       songTitle: "Heaven Knows I'm miserable tonight",
                      //       songImage: "songs/heaven_knows.png",
                      //       singerName: "The Smiths"));
                      // });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 8),
                        child: TextField(
                            controller: _controller,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.alarmGroupNameColor,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: CustomButtonAnimated(
                          label: "Okay, let's Go",
                          onPressed: () async {
                            if (alarmSet.alarms.isNotEmpty) {
                              alarmSet.groupName = _controller.text;
                              await context
                                  .read<AlarmCubit>()
                                  .setNewAlarmGroup(newAlarmGroup: alarmSet);
                              // Navigator.of(context).push(createPageRoute(
                              //     pageRouteType:
                              //         PageRouteTypes.addAlarmToAlarmMain));
                              if (!mounted) return;
                              await context.read<AlarmCubit>().setAlarmGroups();
                              if (!mounted) return;
                              await context.read<AlarmCubit>().getAlarmGroups();
                              if (!mounted) return;
                              context.go("/alarms");
                            } else {}
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
                ...alarmSet.alarms
                    .map((IndividualAlarmModel alarmObject) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Obx( () => IndividualAddedAlarm(alarmObject: alarmObject)),
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
                          Border.all(width: 0.3, color: AppColors.eerieBlack)),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TimePicker()),
                          );

                          // await context
                          //     .read<SpotifyCubit>()
                          //     .getThePlayListsAndTheLibrary();
                          // print("SECOND");
                          //
                          // if (!mounted) return;
                          // await context
                          //     .read<SpotifyCubit>()
                          //     .getTheTracks(playListId: "12");
                          //
                          // if (!mounted) return;
                          // Navigator.of(context).push(createPageRoute(
                          //     pageRouteType:
                          //         PageRouteTypes.addAlarmToPlaylists));
                          //
                          // if(!mounted) return;
                          // print(context.read<SpotifyCubit>().userPlaylists);
                          // print(context.read<SpotifyCubit>().userTracksOfPlaylist);
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
        ]);
      },
    );
  }
}
