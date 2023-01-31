import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:logger/logger.dart';

part "spotify_state.dart";

class SpotifyCubit extends Cubit<SpotifyState> {
  SpotifyCubit() : super(IdleState());

  // SpotifySdk spotifySdk;
  final Logger _logger = Logger(
    //filter: CustomLogFilter(), // custom logfilter can be used to have logs in release mode
    printer: PrettyPrinter(
      methodCount: 2,
      // number of method calls to be displayed
      errorMethodCount: 8,
      // number of method calls if stacktrace is provided
      lineLength: 120,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: true,
    ),
  );

  playTheSong({required String songUrl}) async {}

  stopTheSong({required String songUrl}) async {}

  getTheTracks({required String playListId}) async {}

  getThePlayLists() async {}

  Future<void> disconnect() async {
    try {
      emit(IdleState());
      var result = await SpotifySdk.disconnect();
      emit(NotLoggedIn());
    } on PlatformException catch (e) {
      emit(NotLoggedIn());
    } on MissingPluginException {
      emit(NotLoggedIn());
    }
  }

  Future<void> connectToSpotifyAccount() async {
    try {
      emit(IdleState());
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString());
      setStatus(result
          ? 'connect to spotify successful'
          : 'connect to spotify failed');
      // emit(LoggedIn());
    } catch (e) {
      print(e);
      setStatus(e.toString());

      emit(NotLoggedIn());
    } on PlatformException catch (e) {
      emit(NotLoggedIn());
    } on MissingPluginException {
      emit(NotLoggedIn());
    }
  }

  Future<String> getAccessToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      setStatus('Got a token: $authenticationToken');
      emit(LoggedIn());
      return authenticationToken;
    } on PlatformException catch (e) {
      emit(NotLoggedIn());
      setStatus(e.code, message: e.message);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      emit(NotLoggedIn());
      setStatus('not implemented');
      return Future.error('not implemented');
    }
  }

  Future getPlayerState() async {
    try {
      return await SpotifySdk.getPlayerState();
    } on PlatformException catch (e) {
    } on MissingPluginException {}
  }

  void setStatus(String code, {String? message}) {
    var text = message ?? '';
    _logger.i('$code$text');
  }

  emitIdleState() {
    emit(IdleState());
  }
}
