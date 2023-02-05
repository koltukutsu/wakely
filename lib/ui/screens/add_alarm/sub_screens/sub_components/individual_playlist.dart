import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakely/cubit/spotify/spotify_cubit.dart';
import 'package:wakely/data/models/playlist_and_track_model.dart';
import 'package:wakely/ui/theme/colors.dart';

class IndividualPlaylist extends StatefulWidget {
  final Playlist playListObject;
  final int index;
  final VoidCallback renderFunction;
  final Function({required int userChosenPlaylist}) chosenFunction;
  final bool chosen;

  const IndividualPlaylist(
      {Key? key,
      required this.chosen,
      required this.chosenFunction,
      required this.playListObject,
      required this.index,
      required this.renderFunction})
      : super(key: key);

  @override
  State<IndividualPlaylist> createState() => _IndividualPlaylistState();
}

class _IndividualPlaylistState extends State<IndividualPlaylist> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.chosen == false) {
          print("Chosen playlist");
          widget.chosenFunction(userChosenPlaylist: widget.index - 1);
          context
              .read<SpotifyCubit>()
              .setUserPlaylist(playlistObject: widget.playListObject);
        } else {
          widget.chosenFunction(userChosenPlaylist: -1);
          context.read<SpotifyCubit>().resetUserChoices();
        }
        widget.renderFunction();
      },
      child: Card(
        color: widget.chosen ? AppColors.subPanel1 : AppColors.subPanel,
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 90.0,
              width: 90.0,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  if (widget.playListObject.playListImage !=
                      "assets/images/placeholder.png")
                    Image.network(
                      widget.playListObject.playListImage,
                      fit: BoxFit.cover,
                    )
                  else
                    const Image(
                      image: AssetImage("assets/images/no_playlist.png"),
                      fit: BoxFit.cover,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(widget.index.toString()),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.playListObject.playListName,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
