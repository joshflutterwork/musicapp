import 'dart:convert';

import 'package:musicapp/music/api/music_api.dart';
import 'package:musicapp/music/model/music_model.dart';

class MusicRepo {
  MusicApi musicApi = MusicApi();
  Future<ArtistMusicModel> getArtistMusicRepo({String search}) async {
    var response = await musicApi.getArtistMusicAPI(search: search);
    return ArtistMusicModel.fromJson(jsonDecode(response));
  }
}
