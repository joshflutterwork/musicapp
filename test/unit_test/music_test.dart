import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:musicapp/music/api/music_api.dart';
import 'package:musicapp/music/bloc/music_bloc.dart';
import 'package:musicapp/music/model/music_model.dart';
import 'package:musicapp/music/repo/music_repo.dart';

import '../mock_data.dart';

class MocksAPI extends Mock implements MusicApi {}

class MocksRepo extends Mock implements MusicRepo {}

void main() {
  MusicRepo? musicRepo;

  MusicBloc? musicBloc;

  setUp(() {
    musicRepo = MocksRepo();
    musicBloc = MusicBloc(musicRepo: musicRepo);
  });

  group('Attempt Music API', () {
    test('Music API Success', () {
      ArtistMusicModel resultModel = ArtistMusicModel();

      final dynamic responseJson = json.decode(MockString.musicApiSuccess);
      resultModel = ArtistMusicModel.fromJson(responseJson);

      when(musicRepo?.getArtistMusicRepo(search: "Jackson"))
          .thenAnswer((_) => Future.value(resultModel));

      expectLater(musicBloc?.stream,
          emitsInOrder([MusicLoaded(artistMusicModel: resultModel)]));

      musicBloc?.add(MusicAttempt(search: "Jackson"));
    });

    test('Music API Length Zero', () {
      //mockdata
      ArtistMusicModel resultModel = ArtistMusicModel();

      final dynamic responseJson = json.decode(MockString.musicApiLengthZero);
      resultModel = ArtistMusicModel.fromJson(responseJson);

      when(musicRepo?.getArtistMusicRepo(search: "ksajdhkjas"))
          .thenAnswer((_) => Future.value(resultModel));

      expectLater(musicBloc?.stream,
          emitsInOrder([MusicLoaded(artistMusicModel: resultModel)]));

      musicBloc?.add(MusicAttempt(search: "ksajdhkjas"));
    });
  });
}
