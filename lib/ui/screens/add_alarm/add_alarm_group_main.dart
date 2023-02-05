import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:uuid/uuid.dart';
import 'package:wakely/cubit/alarm/alarm_cubit.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/alarm_group_model.dart';
import 'package:wakely/data/models/individual_alarm_model.dart';
import 'package:wakely/ui/screens/add_alarm/components/alarm_body.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class AddAlarmScreen extends StatefulWidget {
  const AddAlarmScreen({Key? key}) : super(key: key);

  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  final TimeOfDay _time = const TimeOfDay(hour: 4, minute: 30);
  final TextEditingController _controller = TextEditingController();
  AlarmGroupModel alarmSet = AlarmGroupModel(
      groupName: "", id: const Uuid().v1(), alarms: <IndividualAlarmModel>[]);

  void _selectTime() async {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainBackground,
        title: const Text("Choose your Playlist"),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.mainBackgroundColor,
                  border: Border.all(color: AppColors.eerieBlack, width: 0.3)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      context.pop();
                    },
                    highlightColor: AppColors.mainBackgroundColor,
                    icon: const Icon(
                      Icons.chevron_left,
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
                        image: NetworkImage(
                            context.read<SpotifyCubit>().userProfile.userImage),
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
      ),
      backgroundColor: AppColors.mainBackground,
      body: AlarmBody(
          alarmSet: alarmSet, selectTime: _selectTime, controller: _controller),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // IndividualTrack(trackObject: context.read<SpotifyCubit>().userChoices.chosenTrack, index: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
              child: CustomButtonAnimated(
                  label: "Okay, let's pick your Playlist",
                  onPressed: () async {
                    print("NIYE BOYLE OLUYOR");
                    if (alarmSet.alarms.isNotEmpty) {
                      alarmSet.groupName = _controller.text;
                      await context
                          .read<AlarmCubit>()
                          .setNewAlarmGroup(newAlarmGroup: alarmSet);
                      if (!mounted) return;
                      await context.read<AlarmCubit>().setAlarmGroups();
                      if (!mounted) return;
                      await context.read<AlarmCubit>().getAlarmGroups();
                      if (!mounted) return;
                      context.go("/alarms");
                    } else {}
                  },
                  widthRatio: 0.9),
            ),
          ],
        ),
      ),
    );
  }
}
