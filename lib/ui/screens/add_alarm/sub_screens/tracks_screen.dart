import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/sub_components/individual_track.dart';
import 'package:wakely/ui/screens/add_alarm/sub_screens/sub_components/track_body.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class TracksScreen extends StatefulWidget {
  final VoidCallback renderFunction;

  const TracksScreen({Key? key, required this.renderFunction})
      : super(key: key);

  @override
  State<TracksScreen> createState() => _TracksScreenState();
}

class _TracksScreenState extends State<TracksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: TrackBody(renderFunction: () {
        setState(() {
          context.read<SpotifyCubit>().userChoices.chosenTrack;
        });
      }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // IndividualTrack(trackObject: context.read<SpotifyCubit>().userChoices.chosenTrack, index: 1),
            BlocBuilder<SpotifyCubit, SpotifyState>(
              buildWhen: (previous, current) =>
                  current is SpotifyDataLoading ||
                  previous is SpotifyDataLoading,
              builder: (context, state) => Expanded(
                child: Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      context
                                  .read<SpotifyCubit>()
                                  .userChoices
                                  .chosenTrack
                                  .trackImage !=
                              "assets/images/placeholder.png"
                          ? Image(
                              image: NetworkImage(context
                                  .read<SpotifyCubit>()
                                  .userChoices
                                  .chosenTrack
                                  .trackImage),
                              height: 60,
                              width: 60,
                            )
                          : Image(
                              image:
                                  AssetImage("assets/images/placeholder.png"),
                              height: 60,
                              width: 60,
                            ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(context
                              .read<SpotifyCubit>()
                              .userChoices
                              .chosenTrack
                              .trackName),
                          Text(context
                              .read<SpotifyCubit>()
                              .userChoices
                              .chosenTrack
                              .singer)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomButtonAnimated(
                  label: "Let's set it!",
                  widthRatio: 0.3,
                  onPressed: () {
                    print("PRESSED!!!!!!!!!!!!!");
                    widget.renderFunction();
                    context.read<SpotifyCubit>().updateTheState(index: 1);
                    // context.go("/alarms/add_alarm");
                    context.pop();
                    context.pop();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
