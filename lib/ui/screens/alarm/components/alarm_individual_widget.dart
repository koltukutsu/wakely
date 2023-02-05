import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/ui/theme/colors.dart';

class IndividualAlarm extends StatelessWidget {
  final IndividualAlarmModel alarmObject;

  const IndividualAlarm({Key? key, required this.alarmObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SpotifyCubit>().playTheSong(songUrl: alarmObject.songUrl);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.835,
        height: MediaQuery.of(context).size.height * 0.152875,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.mainBackgroundColor,
            border: Border.all(
              color: AppColors.eerieBlack,
              width: 0.3,
            )),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: alarmObject.songImage != "assets/images/placeholder.png"
                  ? Image(
                  image: NetworkImage(alarmObject.songImage),
                  width: 81,
                  height: 81)
                  : const Image(
                  image: AssetImage("assets/images/placeholder.png"),
                  width: 81,
                  height: 81),
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
                        child: Text(alarmObject.singerName,
                            style: const TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 20,
                                // fontFamily: "Inter",
                                fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(alarmObject.alarmTime,
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
                    child: Text(alarmObject.songTitle,
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
      ),
    );
  }
}