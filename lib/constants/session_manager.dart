import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  SessionManager._internal();

  SharedPreferences? sharedPreferences;

  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  static SessionManager get instance => _instance;

  Future<void> initializeSession() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String keyAuthToken = 'auth_token';
  static const String keyUserData = 'users_data';
  static const String keyInstantUserData = 'users_data';
  static const String keyUserProfileData = 'users_profile_data';
  static const String keyUuid = 'uuid';
  static const String logginKey = 'loggin';

  String get authToken => sharedPreferences!.getString(keyAuthToken) ?? '';
  String get uuidData => sharedPreferences!.getString(keyUuid) ?? '';
  bool get isLoggedIn => sharedPreferences?.getBool(logginKey) ?? false;

  set isLoggedIn(bool logging) =>
      sharedPreferences!.setBool(logginKey, logging);

  set authToken(String authToken) =>
      sharedPreferences!.setString(keyAuthToken, authToken);

  set uuidData(String uuidData) =>
      sharedPreferences!.setString(keyUuid, uuidData);

  Map<String, dynamic> get usersData =>
      json.decode(sharedPreferences!.getString(keyUserData) ?? '');

  Map<String, dynamic> get userInstantData =>
      json.decode(sharedPreferences!.getString(keyInstantUserData) ?? '');

  Map<String, dynamic> get usersProfileData =>
      json.decode(sharedPreferences!.getString(keyUserProfileData) ?? '');

  set usersData(Map<String, dynamic> map) =>
      sharedPreferences!.setString(keyUserData, json.encode(map));

  set userInstantData(Map<String, dynamic> map) =>
      sharedPreferences!.setString(keyInstantUserData, json.encode(map));

  set usersProfileData(Map<String, dynamic> map) =>
      sharedPreferences!.setString(keyUserProfileData, json.encode(map));

  Future<bool> logOut() async {
    await sharedPreferences!.clear();
    // try {
    //   // final cacheDir = await getTemporaryDirectory();
    //   if (cacheDir.existsSync()) {
    //     cacheDir.deleteSync(recursive: true);
    //   }
    //   final appDir = await getApplicationSupportDirectory();
    //   if (appDir.existsSync()) {
    //     appDir.deleteSync(recursive: true);
    //   }
    // } catch (e) {
    //   // logger.d("error clearing cache");
    // }
    return true;
  }
}
