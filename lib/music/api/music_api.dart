import 'package:dio/dio.dart';
import 'package:musicapp/util/network_util.dart';

class MusicApi {
  getArtistMusicAPI({String? search}) async {
    try {
      Response response = await NetworkUtil.get(path: 'search?term=$search');
      return response.data;
    } catch (e) {
      return e.toString();
    }
  }
}
