import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:login_project/constants/constants.dart';

import '../model/categories.dart';
import 'network_response.dart';

class RestUtils {
  Future<NetworkResponse?> getDataFromAPI(String pathURL) async {
    var networkResponse = NetworkResponse();
    final dio = await _processDio();
    try {
      final response = await dio.get(pathURL);
      if (response.statusCode == 200) {
        networkResponse
          ..statusCode = response.statusCode
          ..body = CategoriesResponse.fromJson(json.decode(response.data));
      } else {
        return null;
      }
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.connectTimeout) {
        return null;
      } else if (ex.type == DioErrorType.receiveTimeout) {
        return null;
      }
      if (ex.response?.statusCode == 404) {
        return null;
      }
      if (ex.type == DioErrorType.other) {
        return null;
      }
    }
    return networkResponse;
  }

  Future<Dio> _processDio() async {
    final dio = Dio();

    dio.options.baseUrl = API.domain;
    dio.options.connectTimeout = 1000 * 15;
    dio.options.receiveTimeout = 1000 * 15;
    /// Handle in future
    // dio.options.headers["UserID"] = "condung_id_1";
    // dio.options.headers["Authorization"] = "Bearer $accessToken";
    // dio.interceptors.clear();
    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onError: (error, handler) {
    //       if (error.response?.statusCode == 403 ||
    //           error.response?.statusCode == 401) {
    //         /// Implement refreshToken
    //       }
    //     },
    //   ),
    // );
    return dio;
  }
}
