import 'package:flutter/material.dart';
import 'package:wakely/ui/navigation/navigation_names.dart';
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
  List<IndividualAlarmModel> alarmSet = [
    IndividualAlarmModel(
        alarmTime: "03:40",
        songTitle: "This Charming Man - 2011 Remastered",
        songBackgroundColor: const Color(0xFF502030),
        songImage: "songs/this_charming_man.png",
        singerName: "The Smiths"),
    IndividualAlarmModel(
        alarmTime: "04:45",
        songTitle: "Heaven Knows I'm miserable tonight",
        songBackgroundColor: const Color(0xFF4A79AF),
        songImage: "songs/heaven_knows.png",
        singerName: "The Smiths"),
  ];

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            margin: const EdgeInsets.only(top: 12, right: 12, left: 12),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.alarmGroupCardColor,
                border: Border.all(
                  color: AppColors.eerieBlack,
                  width: 1.5,
                )),
            child: Column(
              children: [
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        alarmSet.add(IndividualAlarmModel(
                            alarmTime: "04:45",
                            songTitle: "Heaven Knows I'm miserable tonight",
                            songBackgroundColor: const Color(0xFF4A79AF),
                            songImage: "songs/heaven_knows.png",
                            singerName: "The Smiths"));
                      });
                    },
                    icon: Icon(Icons.add),
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
                          onPressed: () {},
                          widthRatio: 0.4),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 8.0, left: 8),
                  child: Divider(color: AppColors.eerieBlack, thickness: 1.2),
                ),
                ...alarmSet.map((IndividualAlarmModel alarmObject) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: IndividualAlarm(alarmObject: alarmObject),
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
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(createPageRoute(
                      pageRouteType: PageRouteTypes.alarmMainToAddAlarm));
                },
                icon: const Icon(
                  Icons.add,
                  color: AppColors.eerieBlack,
                ),
                color: AppColors.tropicalViolet,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: AppColors.eerieBlack,
                ),
                color: AppColors.tropicalViolet,
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
          // SliverList(
          //     delegate: SliverChildListDelegate([
          //       Container(
          //           padding: const EdgeInsets.only(top: 10),
          //           margin: const EdgeInsets.only(top: 12, right: 12, left: 12),
          //           width: MediaQuery.of(context).size.width * 0.9,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(20),
          //               color: AppColors.alarmGroupCardColor,
          //               border: Border.all(
          //                 color: AppColors.eerieBlack,
          //                 width: 1.5,
          //               )),
          //           child: Column(
          //             children: [
          //               Center(
          //                 child: IconButton(
          //                   onPressed: () {
          //                     setState(() {
          //                       alarmSet.add(IndividualAlarmModel(
          //                           alarmTime: "04:45",
          //                           songTitle: "Heaven Knows I'm miserable tonight",
          //                           songBackgroundColor: const Color(0xFF4A79AF),
          //                           songImage: "songs/heaven_knows.png",
          //                           singerName: "The Smiths"));
          //                     });
          //                   },
          //                   icon: Icon(Icons.add),
          //                 ),
          //               ),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Expanded(
          //                     flex: 2,
          //                     child: Padding(
          //                       padding: const EdgeInsets.only(left: 18.0, right: 8),
          //                       child: TextField(
          //                           style: const TextStyle(
          //                             fontSize: 28,
          //                             fontWeight: FontWeight.bold,
          //                             color: AppColors.alarmGroupNameColor,
          //                           )),
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(right: 12.0),
          //                     child: CustomButtonAnimated(
          //                         label: "Okay, let's Go",
          //                         onPressed: () {},
          //                         widthRatio: 0.4),
          //                   )
          //                 ],
          //               ),
          //               const Padding(
          //                 padding: EdgeInsets.only(right: 8.0, left: 8),
          //                 child: Divider(color: AppColors.eerieBlack, thickness: 1.2),
          //               ),
          //               ...alarmSet.map((IndividualAlarmModel alarmObject) => Padding(
          //                 padding: const EdgeInsets.only(bottom: 12.0),
          //                 child: IndividualAlarm(alarmObject: alarmObject),
          //               )),
          //               const SizedBox(
          //                 height: 8,
          //               )
          //               // ...List.generate(widget.alarmSet.map, (index) => null)
          //             ],
          //           ))
          //     ])),
        ]);
      },
    );
  }
}
