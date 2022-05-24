import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:musicapp/music/model/music_model.dart';
import 'package:musicapp/music/repo/music_repo.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicRepo musicRepo = MusicRepo();
  ArtistMusicModel artistMusicModel = ArtistMusicModel();
  MusicBloc({this.musicRepo}) : super(MusicInitial()) {
    on<MusicAttempt>((event, emit) async {
      try {
        var response = await musicRepo.getArtistMusicRepo(search: event.search);
        if (response is ArtistMusicModel) {
          emit(MusicLoaded(artistMusicModel: response));
        } else {
          emit(MusicError(error: "error"));
        }
      } catch (e) {
        emit(MusicError(error: e.toString()));
      }
    });
  }
}
