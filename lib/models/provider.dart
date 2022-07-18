import 'package:flutter/material.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/utils/api_call.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../repository/auth_repo.dart';
import '../states/auth_state.dart';
import '../utils/driver_utils.dart';

class GoogleApiProvider extends ChangeNotifier {
  GoogleApiProvider();

  final AuthRepo authRepo = AuthRepo();
  String? get timeResponse => _timeResponse;
  String? get time => _time;
  String? get timeResponseExecutive => _timeResponseExecutive;
  String? get timeResponseCoperate => _timeResponseCoperate;
  String? _time;
  String? _timeResponse;
  String? _timeResponseExecutive;
  String? _timeResponseCoperate;
  AuthController? authController;
  List? _estimatedCostList;
  int? classicEsCost;
  int? executiveEsCost;
  int? coperateEsCost;

  getTimeFromGoogleApi({String? origin, String? destination}) async {
    try {
      var response =
          await makeNetworkCall(origin: origin, destination: destination);
      for (int i = 0; i < response['rows'].length; i++) {
        var res = response["rows"][i]['elements'];
        for (int j = 0; j < res.length; j++) {
          _timeResponse = res[j]['duration']['text'];
        }
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    return _timeResponse;
  }

  getTimeFromGoogleApiExe({String? origin, String? destination}) async {
    try {
      var response =
          await makeNetworkCall(origin: origin, destination: destination);
      for (int i = 0; i < response['rows'].length; i++) {
        var res = response["rows"][i]['elements'];
        for (int j = 0; j < res.length; j++) {
          _timeResponseExecutive = res[j]['duration']['text'];
        }
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    return _timeResponseExecutive;
  }

  getTimeFromGoogleApiCoperate({String? origin, String? destination}) async {
    try {
      var response =
          await makeNetworkCall(origin: origin, destination: destination);
      for (int i = 0; i < response['rows'].length; i++) {
        var res = response["rows"][i]['elements'];
        for (int j = 0; j < res.length; j++) {
          _timeResponseCoperate = res[j]['duration']['text'];
        }
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    return _timeResponseCoperate;
  }

  Future<int?> getTimeCostFromGoogleApi() async {
    try {
      var response = await makeNetworkCall(
          origin: pickUpLocationAdd, destination: dropLocationAdd);
      for (int i = 0; i < response['rows'].length; i++) {
        var res = response["rows"][i]['elements'];
        for (int j = 0; j < res.length; j++) {
          _time = res[j]['duration']['text'];
          print('objectof time $_time');
        }
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }

    print(time);

    List<String> _timeList = _time!.split(' ');
    print(_timeList);
    notifyListeners();
    return convertToMinutes(_timeList);
  }

  int? convertToMinutes(List<String> times) {
    if (times.isEmpty) return DateTime.now().minute;
    if (times.length == 4) {
      int hour = int.parse(times[0]);
      int minute = int.parse(times[2]);
      return Duration(hours: hour, minutes: minute).inMinutes;
    } else {
      if (times[1] == 'hour' || times[1] == 'hours') {
        return Duration(hours: int.parse(times[0])).inMinutes;
      }
      if (times[1] == 'min' || times[1] == 'mins') {
        return Duration(minutes: int.parse(times[0])).inMinutes;
      }
    }
    notifyListeners();
    return DateTime.now().minute;
  }

  void estimatedCost(String minDuration) async {
    var distance = DriversUtil.getDistanceFromLatLonInKm(
        double.parse(pickUpLat!),
        double.parse(pickUpLong!),
        double.parse(dropLat!),
        double.parse(dropLong!));

    _estimatedCostList = await authRepo.estimatedCost({
      "distance": distance,
      "duration": minDuration,
      "drop_lat": dropLat,
      "drop_lng": dropLong
    });

    for (int i = 0; i < _estimatedCostList!.length; i++) {
      classicEsCost = _estimatedCostList?[i]['Classic'].toInt() ?? 0;
      notifyListeners();
      executiveEsCost = _estimatedCostList?[i]['Executive'] ?? 0;
      notifyListeners();
      coperateEsCost = _estimatedCostList?[i]['Coperative'] ?? 0;
      notifyListeners();
    }
    notifyListeners();
  }
}

class Providers {
  static List<SingleChildWidget> getProviders = [
    ChangeNotifierProvider<GoogleApiProvider>(
        create: (_) => GoogleApiProvider()),
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
  ];
}
