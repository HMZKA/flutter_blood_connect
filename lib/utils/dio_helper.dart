import 'package:dio/dio.dart';
import 'package:flutter_blood_connect/constants.dart';
import 'package:flutter_blood_connect/utils/app_cache.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(baseUrl: "$baseUrl/api/", headers: {
      "Accept": "application/json",
      'ngrok-skip-browser-warning': 'skip-browser-warning'
    }));
  }

  static Future<Response?> get(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    return await dio?.get(path,
        queryParameters: queryParameters,
        options: Options(headers: {
          "Authorization": "Bearer ${AppCache.getData(key: "token") ?? ""}",
          "Content-Type": "multipart/form-data"
        }));
  }

  static Future<Response?> post(
      {required String path, required dynamic data}) async {
    return await dio?.post(path,
        data: data,
        options: Options(headers: {
          "Authorization": "Bearer ${AppCache.getData(key: "token") ?? ""}"
        }));
  }
}
