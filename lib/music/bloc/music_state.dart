part of 'music_bloc.dart';

@immutable
abstract class MusicState extends Equatable {
  @override
  List<Object> get props => [];
}

class MusicInitial extends MusicState {
  @override
  List<Object> get props => [];
}

class MusicLoading extends MusicState {
  @override
  List<Object> get props => [];
}

class MusicLoaded extends MusicState {
  final ArtistMusicModel artistMusicModel;
  MusicLoaded({this.artistMusicModel});
  @override
  List<Object> get props => [artistMusicModel];
}

class MusicError extends MusicState {
  final String error;
  MusicError({this.error});
  @override
  List<Object> get props => [error];
}
