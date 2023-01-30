import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "spotify_state.dart";

class SpotifyCubit extends Cubit<SpotifyState> {
  SpotifyCubit() : super(IdleState());

  playTheSong({required String songUrl}) async {
  }

  stopTheSong({required String songUrl}) async {

  }

  getTheSong() async {

  }

  getThePlayLists() async {

  }

}
