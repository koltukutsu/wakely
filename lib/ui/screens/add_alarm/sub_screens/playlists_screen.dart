import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/sub_components/playlist_body.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/tracks_screen.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class PlayListsScreen extends StatefulWidget {
  const PlayListsScreen({Key? key, required this.renderFunction})
      : super(key: key);
  final VoidCallback renderFunction;

  // final VoidCallback secondRenderFunction;

  @override
  State<PlayListsScreen> createState() => _PlayListsScreenState();
}

class _PlayListsScreenState extends State<PlayListsScreen> {
  secondRenderFunction() {
    setState(() {
      context.read<SpotifyCubit>().userChoices.chosenPlaylist.playListImage;
      context.read<SpotifyCubit>().userChoices.chosenPlaylist.playListName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: PlaylistBody(secondRenderFunction: secondRenderFunction),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // IndividualTrack(trackObject: context.read<SpotifyCubit>().userChoices.chosenTrack, index: 1),
            Expanded(
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (context
                            .read<SpotifyCubit>()
                            .userChoices
                            .chosenPlaylist
                            .playListImage !=
                        "assets/images/placeholder.png")
                      Image(
                        image: NetworkImage(context
                            .read<SpotifyCubit>()
                            .userChoices
                            .chosenPlaylist
                            .playListImage),
                        height: 60,
                        width: 60,
                      )
                    else
                      const Image(
                        image: AssetImage("assets/images/placeholder.png"),
                        height: 60,
                        width: 60,
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          maxLines: 3,
                          context
                              .read<SpotifyCubit>()
                              .userChoices
                              .chosenPlaylist
                              .playListName,
                          style: const TextStyle(color: AppColors.fontColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomButtonAnimated(
                  label: "Let's go!",
                  widthRatio: 0.4,
                  onPressed: () {
                    print(context
                        .read<SpotifyCubit>()
                        .userChoices
                        .chosenPlaylist
                        .playListImage);
                    print("PRESSED!!!!!!!!!!!!!");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TracksScreen(
                            renderFunction: widget.renderFunction)));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
