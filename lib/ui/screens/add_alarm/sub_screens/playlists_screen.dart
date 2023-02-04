import 'package:flutter/material.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/sub_components/playlist_body.dart';
import 'package:wakely/ui/theme/colors.dart';

class PlayListsScreen extends StatefulWidget {
  const PlayListsScreen({Key? key}) : super(key: key);
  @override
  State<PlayListsScreen> createState() => _PlayListsScreenState();
}

class _PlayListsScreenState extends State<PlayListsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: PlaylistBody(),
    );
  }
}
