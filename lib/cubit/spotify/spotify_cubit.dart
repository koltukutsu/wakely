import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:logger/logger.dart';
import 'package:wakely/data/models/user_model.dart';

part "spotify_state.dart";

enum UserStates { premium, free, problem }

class SpotifyCubit extends Cubit<SpotifyState> {
  SpotifyCubit() : super(IdleState());
  User userProfile =
      User(name: "", userName: "", userImage: "", userState: "Free");
  String token = "";

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

  Future<UserStates> getTheUserProfile() async {
    // await SpotifySdk.
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await dio.get('https://api.spotify.com/v1/me',
          queryParameters: {'scope': 'user-read-private'});
      // UserStates userState = response.data["product"] == "premium"
      //     ? UserStates.premium
      //     : UserStates.free;
      UserStates userState = UserStates.premium;
      print(response.data);
      if (userState == UserStates.premium) {
        print("Yes");
        userProfile.name = response.data["display_name"];
        userProfile.userName = response.data["id"];
        userProfile.userImage = response.data["images"][0]["url"];
        // TODO: show that the user is premium
      } else {
        print("No");
        // TODO: show that the user is free

      }
      if (userState == UserStates.premium) {
        userProfile.userState = "Premium";
      }
      return userState;
    } catch (e) {
      setStatus("Un Error Ocurro");
      setStatus(e.toString());
      userProfile.userState = "Problem";
      return UserStates.problem;
    }
  }

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
    emit(SpotifyDataLoading());
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      setStatus('Got a token: $authenticationToken');
      token = authenticationToken;

      UserStates userState = await getTheUserProfile();
      print(userState);
      if (userState == UserStates.premium) {
        print("inside");
        emit(LoggedIn());
      } else if (userState == UserStates.premium) {
        print("inside2");
        emit(NotPremium());
      } else {
        print("inside3");
        emit(NotLoggedIn());
      }

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

  Future<void> checkIfAppIsActive() async {
    try {
      var isActive = await SpotifySdk.isSpotifyAppActive;
      setStatus(isActive.toString());
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  void setStatus(String code, {String? message}) {
    var text = message ?? '';
    _logger.i('$code$text');
  }

  emitIdleState() {
    emit(IdleState());
  }
}
