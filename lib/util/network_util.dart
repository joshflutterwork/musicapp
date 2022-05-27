import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkUtil {
  static Dio _dio = Dio()..options.connectTimeout = 30000;

  static String baseurl = "https://itunes.apple.com/";

  NetworkUtil._();

  static final NetworkUtil _instance = NetworkUtil._();

  factory NetworkUtil() {
    return _instance;
  }

  static Future<Response> get({
    String? url,
    @required String? path,
  }) async {
    try {
      final Response res = await _dio.get((url ?? baseurl) + path!);

      debugPrint("CALLING HEADERS " + res.requestOptions.headers.toString());
      debugPrint("CALIING METHOD " + res.requestOptions.method.toString());
      debugPrint("CALLING PATH " + res.requestOptions.path);

      return res;
    } on DioError catch (e) {
      _errorCatch(e);
      try {
        throw e;
      } catch (e) {
        rethrow;
      }
    } catch (e) {
      throw "Something Went Wrong";
    }
  }

  static void _errorCatch(DioError e) {
    try {
      if (e.response != null) {
        debugPrint("Error HEADERS " + e.requestOptions.headers.toString());
        debugPrint("Error METHOD " + e.requestOptions.method.toString());
        debugPrint("Error CALLING " + e.requestOptions.path.toString());
        debugPrint("Error Status Code " + e.response!.statusCode.toString());
        debugPrint(
            "Error Response " + e.response!.data['error_code'].toString());
        debugPrint('Error Message ' + e.response!.data['message'].toString());
        debugPrint(
            "Error QUERY " + e.requestOptions.queryParameters.toString());
      } else {
        debugPrint("CALLING " + e.requestOptions.toString());
      }
    } on Exception catch (e) {
      debugPrint("Exception $e");
    }
  }
}
