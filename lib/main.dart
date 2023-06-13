import 'dart:isolate';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:wakely/ui/main_app.dart';

@pragma('vm:entry-point')
void alarmCallback(int counter, Map<String, dynamic> params) async {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("CALISTIIYOR");
  print("Setting the song ${params["songUrl"]}");
  try {
    print("Loading the env file");
    await dotenv.load(fileName: '.env');
    print("Env file loaded");
    print("Starting spotify sdk");
    var result = await SpotifySdk.connectToSpotifyRemote(
        clientId: dotenv.env['CLIENT_ID'].toString(),
        redirectUrl: dotenv.env['REDIRECT_URL'].toString());
    print("Spotify sdk started $result");
    print("Ssetting the song....");
    // spotify:track:7EkWXAI1wn8Ii883ecd9xr
    await SpotifySdk.play(spotifyUri: params["songUrl"]);
    print("Song is set.");
  } on PlatformException catch (e) {
// setStatus(e.code, message: e.message);
    print("${e.code} + ${e.message}");
  } on MissingPluginException {
    print('not implemented');
  }
  print(
      "[$now] 33 Hello, world! isolate=${isolateId} function='$alarmCallback'");
}

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(const MainApp());
}
