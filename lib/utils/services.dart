import 'dart:async';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:my_ride/constants/constants.dart';
import 'package:my_ride/constants/session_manager.dart';
import 'package:my_ride/utils/nav_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

mixin Services {
  static final Map<String, String> _requestHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Dio> getDio() async {
    Dio dio;
    String baseUrl = Constants.baseUrl;

    BaseOptions _options = BaseOptions(
      baseUrl: baseUrl,
      headers: _requestHeaders,
      connectTimeout: 200000,
      receiveTimeout: 200000,
    );

    dio = Dio(_options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // const bool isProduction = bool.fromEnvironment('dart.vm.product');
    // if (!isProduction) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 10090,
      ),
    );
    // }

    return dio;
  }

    Future<Dio> getFcmDio() async {
    Dio dio;
    String fcmBaseUrl = Constants.fcmBaseUrl;

    BaseOptions _options = BaseOptions(
      baseUrl: fcmBaseUrl,
      headers: _requestHeaders,
      connectTimeout: 200000,
      receiveTimeout: 200000,
    );

    dio = Dio(_options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // const bool isProduction = bool.fromEnvironment('dart.vm.product');
    // if (!isProduction) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 10090,
      ),
    );
    // }

    return dio;
  }

  Future<Map<String, dynamic>?> apiFcmPostRequests(
      String endPoint, Map<String, dynamic> credentials,
      {Map<String, dynamic>? header}) async {
    try {
      header ??= {};

      Dio dio = await getFcmDio();
      Response response = await dio.post(endPoint,
          data: credentials,
          options: Options(headers: {
            "Authorization": "key=AAAAapkT0IM:APA91bHly3mpmpelRfPuYzYHnIU01wxSLrykzXcj9O4QM6vmk2D0ixj7ZYba6c16gqqa8mc8izXUVY_Pz31Z5Kh72VH0D-li7yquH5GQxeK50SoTAdC5-FlKKUKlCokHJbdM6pfYkkgs",
            ...header
          }));
      return response.data;
    } on DioError catch (e) {
      debugPrint("e.toString()");
      print(e.toString());
      // return "";
      return {};
    }
  }

  Future<Map<String, dynamic>?> apiPostRequests(
      String endPoint, Map<String, dynamic> credentials,
      {Map<String, dynamic>? header}) async {
    try {
      header ??= {};

      Dio dio = await getDio();
      Response response = await dio.post(endPoint,
          data: credentials,
          options: Options(headers: {
            "Authorization": "Bearer " + await getAuthToken(),
            ...header
          }));
      return response.data;
    } on DioError catch (e) {
      debugPrint("e.toString()");
      print(e.toString());
      return {};
    }
  }

  Future <List<dynamic>?> apiPostQudusRequests(
      String endPoint, Map<String, dynamic> credentials,
      {Map<String, dynamic>? header}) async {
    try {
      header ??= {};

      Dio dio = await getDio();
      Response response = await dio.post(endPoint,
          data: credentials,
          options: Options(headers: {
            "Authorization": "Bearer " + await getAuthToken(),
            ...header
          }));
      return response.data;
    } on DioError catch (e) {
      debugPrint("e.toString()");
      print(e.toString());
      return [];
    }
  }

  Future<Map<String, dynamic>?> apiUploadPostRequests(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      Dio dio = await getDio();
      final response = await dio.post(endPoint,
          data: FormData.fromMap(credentials),
          options: Options(headers: {
            "Authorization": "Bearer " + await getAuthToken(),
            "Content-Type": "multipart/form-data"
          }));
//      print(response);
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return catchError(e);
    }
  }

  Future<Map<String, dynamic>?> apiGetRequests(String endPoint) async {
    try {
      Dio dio = await getDio();
      Response response = await dio.get(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getAuthToken()}));
      //  debugPrint(response.data.toString());
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return catchError(e);
    }
  }

  Future<Map<String, dynamic>?> apiDeleteRequests(String endPoint) async {
    try {
      Dio dio = await getDio();
      Response response = await dio.delete(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getAuthToken()}));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return catchError(e);
    }
  }

  Future<dynamic> apiDeleteRequestsWithFullResponse(String endPoint) async {
    try {
      Dio dio = await getDio();
      return await dio.delete(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getAuthToken()}));
    } on DioError catch (e) {
      return catchError(e);
    }
  }

  Future<Map<String, dynamic>?> apiPatchRequests(String endPoint) async {
    try {
      Dio dio = await getDio();
      final response = await dio.patch(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + await getAuthToken()}));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return catchError(e);
    }
  }

  Future<Map<String, dynamic>?> apiPatchWithDataRequests(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      Dio dio = await getDio();
      final response = await dio.patch(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getAuthToken()}));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return catchError(e);
    }
  }

  Future<Map<String, dynamic>?> apiPutRequests(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      Dio dio = await getDio();
      final response = await dio.put(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getAuthToken()}));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      print(e);
      return catchError(e);
    }
  }

  Future<Map<String, dynamic>?> apiUploadPutRequests(
      String endPoint, FormData credentials) async {
    try {
      // print(credentials.files);
      Dio dio = await getDio();
      final response = await dio.post(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getAuthToken()}));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      print(e);
      return catchError(e);
    }
  }

  Future<Map<String, dynamic>?> apiPatchRequestsWithCredentials(
      String endPoint, Map<String, dynamic> credentials) async {
    try {
      Dio dio = await getDio();
      final response = await dio.patch(endPoint,
          data: credentials,
          options: Options(
              headers: {"Authorization": "Bearer " + await getAuthToken()}));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return catchError(e);
    }
  }

  Future<Map<String, dynamic>?> apiImageUpload(
      String endPoint, FormData formdata) async {
    try {
      Dio dio = await getDio();
      final response = await dio.post(endPoint,
          data: formdata,
          options: Options(
              headers: {"Authorization": "Bearer " + await getAuthToken()}));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return catchError(e);
    }
  }

  Future<Map<String, dynamic>?> apiGenericGetRequest(
      String token, String endPoint, String baseUrl) async {
    try {
      Dio dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: _requestHeaders,
        connectTimeout: 200000,
        receiveTimeout: 200000,
      ));
      final response = await dio.get(endPoint,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return convert.json.decode(response.toString());
    } on DioError catch (e) {
      return catchError(e);
    }
  }

  catchError(DioError e) {
    if (e.message.toString().contains("SocketException")) {
      throw ({
        "status": "error",
        "message": "Network Error! Check your internet connection."
      });
    }

    if (e.message.toString().contains("timed out")) {
      throw ({"status": "error", "message": "Connection timeout."});
    }

    if (e.message.toString().contains("CONNECT_TIMEOUT")) {
      return {"status": "error", "message": "Connection timeout."};
    }

    if (e.message.runtimeType.toString() == "String") {
      return {"status": "error", "message": e.message};
    }

    if (e.response?.statusCode == 422) {
      return {
        "status": "error",
        "message": e.response?.data?["data"],
        "email":e.response?.data?["data"]["errors"]["email"]
      };
    }

    if (e.response != null) {
      checkForExpiredToken(e);

      return {
        "status": "error",
        "message": e.response?.data,
      };
    } else {
      return {
        "status": "error",
        "message": "Error connecting to network!",
      };
    }
  }

  getAuthToken() async {
    String? accessToken =  SessionManager.instance.authToken;

    return accessToken;

  }

  checkForExpiredToken(DioError e) {
    if (e.response != null &&
        e.response!.data.runtimeType.toString().toLowerCase().contains("map")) {
      if (e.response!.data["message"]
          .toString()
          .toLowerCase()
          .contains("unauthenticated")) {
        GetIt locator = GetIt.instance;
        final NavigationService _navigationService =
            locator<NavigationService>();
        _navigationService.logOut();
      }
    }
  }
}
