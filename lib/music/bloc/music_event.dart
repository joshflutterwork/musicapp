part of 'music_bloc.dart';

@immutable
abstract class MusicEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MusicAttempt extends MusicEvent {
  String search;
  MusicAttempt({this.search});
  @override
  List<Object> get props => [search];
}
