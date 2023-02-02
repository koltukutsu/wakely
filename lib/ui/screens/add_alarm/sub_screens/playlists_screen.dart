import 'package:flutter/material.dart';
import 'package:wakely/ui/theme/colors.dart';

class PlayListsScreen extends StatefulWidget {
  const PlayListsScreen({Key? key}) : super(key: key);

  @override
  State<PlayListsScreen> createState() => _PlayListsScreenState();
}

class _PlayListsScreenState extends State<PlayListsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.seaFoamOriginalGreen,
    );
  }
}
