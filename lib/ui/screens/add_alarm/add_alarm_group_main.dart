import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wakely/ui/screens/add_alarm/components/alarm_body.dart';
import 'package:wakely/ui/theme/colors.dart';

class AddAlarmScreen extends StatefulWidget {
  const AddAlarmScreen({Key? key}) : super(key: key);

  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.seaFoamOriginalGreen,
      body: AlarmBody(),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   items: const <BottomNavigationBarItem>[
      //   ],
      // ),

    );
    // body: SlidingUpPanel(
    //   maxHeight: MediaQuery.of(context).size.height,
    //   minHeight: MediaQuery.of(context).size.height * 0.8,
    //   renderPanelSheet: false,
    //   backdropEnabled: true,
    //   parallaxEnabled: true,
    //   color: AppColors.seaFoamOriginalGreen,
    //
    //   // backdropOpacity: 0.6,
    //   // body: const AlarmBody(),
    //   // collapsed: const SwipeDock(),
    //   panel: const AlarmBody(),
    // ));
  }
}
