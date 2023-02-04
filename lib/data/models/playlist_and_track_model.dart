class TrackSong {
  final String trackImage;
  final String trackName;
  final String uri;
  final String singer;

  // final String trackLength;

  TrackSong({
    required this.trackImage,
    required this.trackName,
    required this.uri,
    required this.singer,
    // required this.trackLength,
  });

  // var trackName = track['track']['name'];
  // var artistName = track['track']['artists'][0]['name'];
  // var trackUri = track['track']['uri'];
  // var trackImage = track['track']['album']['images'][0]['url'];
  TrackSong.fromJson(Map<String, dynamic> json)
      : trackImage = json['track']['album']['images'][0]['url'] ?? "-",
        trackName = json["track"]["name"],
        uri = json["track"]["uri"],
        singer = json["track"]["artists"][0]["name"];
// trackLength = json["track"][""];
}

class Playlist {
  final String playListImage;
  final String playListName;
  final String id;
  // final String singer;
  // final String totalTrackNumber;

  Playlist({
    required this.playListImage,
    required this.playListName,
    required this.id
  });
  //
  // Playlist.fromJson(Map<String, dynamic> json)
  //     : playListName = json["name"],
  //       playListImage = giveThePlayListImage(json);

  String giveThePlayListImage(dynamic taken) {
    String given;
    try{
      given = taken['images'][0]['url'];
    }catch (e) {
      given = "NO PLAYLIST IMAGE";
    }

    return given;
  }
}

class UserPlayListAndTrack {
  Playlist chosenPlaylist;
  TrackSong chosenTrack;

  UserPlayListAndTrack(
      {required this.chosenPlaylist, required this.chosenTrack});
}
