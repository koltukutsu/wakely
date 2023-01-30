import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "spotify_state.dart";

class SpotifyCubit extends Cubit<SpotifyState> {
  SpotifyCubit() : super(IdleState());

  undefined() async {
  }

}
