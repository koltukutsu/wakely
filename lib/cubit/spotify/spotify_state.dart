part of "spotify_cubit.dart";


abstract class SpotifyState extends Equatable {
  const SpotifyState();

  @override
  List<Object> get props => [];
}

class IdleState extends SpotifyState {
  @override
  List<Object> get props => [];
}

class LoggedIn extends SpotifyState {
  @override
  List<Object> get props => [];
}

class NotLoggedIn extends SpotifyState {
  @override
  List<Object> get props => [];
}

class NotPremium extends SpotifyState {
  @override
  List<Object> get props => [];
}
