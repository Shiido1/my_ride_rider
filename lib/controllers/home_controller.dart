import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/repository/auth_repo.dart';
import 'package:my_ride/utils/driver_utils.dart';

import '../constants/session_manager.dart';
import '../models/driver.model.dart';
import '../utils/Flushbar_mixin.dart';
import '../utils/api_call.dart';

class HomeController extends ControllerMVC with FlushBarMixin {
  factory HomeController([StateMVC? state]) =>
      _this ??= HomeController._(state);
  HomeController._(StateMVC? state)
      : model = HomeModel(),
        super(state);
  static HomeController? _this;

  final HomeModel model;
  final AuthRepo authRepo = AuthRepo();
  var resTimeClassic, resTimeExecutive, resTimeCoperate;

  void closeDrawer() {
    Navigator.of(state!.context).pop();
  }

  void getUserData() async {
    setState(() {
      model.isLoading = true;
    });

    try {
      Map<String, dynamic>? response = await authRepo.getUserInfo();
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        SessionManager.instance.usersData = response["data"];
        print('print user res: $response');
      } else {
        showErrorNotification(state!.context, response!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
    setState(() {
      model.isLoading = false;
    });
  }

  getTimeFromGoogleApi({String? origin, String? destination}) async {
    try {
      var response =
          await makeNetworkCall(origin: origin, destination: destination);
      print(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

class HomeModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController pickupController =
      TextEditingController(text: pickUpLocationAdd);
  final TextEditingController destinationController =
      TextEditingController(text: dropLocationAdd);

  String demoPickUp = "";
  String demoDestination = "";
  String focusInput = "pickup";
  bool isLoading = false;
}
