import 'package:flutter/material.dart';
import 'package:my_ride/utils/api_call.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../states/auth_state.dart';

class GoogleApiProvider extends ChangeNotifier {
  GoogleApiProvider();
  String? get timeResponse => _timeResponse;
  String? get timeResponseExecutive => _timeResponseExecutive;
  String? get timeResponseCoperate => _timeResponseCoperate;
  String? _timeResponse;
  String? _timeResponseExecutive;
  String? _timeResponseCoperate;

  getTimeFromGoogleApi({String? origin, String? destination}) async {
    try {
      var response =
          await makeNetworkCall(origin: origin, destination: destination);
      for (int i = 0; i < response['rows'].length; i++) {
        var res = response["rows"][i]['elements'];
        print('print res $res');
        for (int j = 0; j < res.length; j++) {
          _timeResponse = res[j]['duration']['text'];
        }
      }
      print(_timeResponse);
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
        print('print res $res');
        for (int j = 0; j < res.length; j++) {
          _timeResponseExecutive = res[j]['duration']['text'];
        }
      }
      print(_timeResponseExecutive);
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
        print('print res $res');
        for (int j = 0; j < res.length; j++) {
          _timeResponseCoperate = res[j]['duration']['text'];
        }
      }
      print(_timeResponseCoperate);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    return _timeResponseCoperate;
    
  }
}

class Providers {
  static List<SingleChildWidget> getProviders = [
    ChangeNotifierProvider<GoogleApiProvider>(
        create: (_) => GoogleApiProvider()),
    ChangeNotifierProvider<AuthProvider>(
        create: (_) => AuthProvider()),
  ];
}
