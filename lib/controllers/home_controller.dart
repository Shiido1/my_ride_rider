import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/repository/auth_repo.dart';
import '../constants/session_manager.dart';
import '../utils/Flushbar_mixin.dart';
import '../utils/driver_utils.dart';
import '../utils/router.dart';
import '../widget/map_screen.dart';

class HomeController extends ControllerMVC with FlushBarMixin {
  factory HomeController([StateMVC? state]) =>
      _this ??= HomeController._(state);
  HomeController._(StateMVC? state)
      : model = HomeModel(),
        super(state);
  static HomeController? _this;

  final HomeModel model;
  final AuthRepo authRepo = AuthRepo();

  void closeDrawer() {
    Navigator.of(state!.context).pop();
  }

  void sendPushNotChangeLoc() async {
    setState(() {
      model.isPushChangeLocLoading = true;
    });

    try {
      Map<String, dynamic>? response = await authRepo.sendPushNot({
        "to": token,
        "notification": {
          "title": "You have just received a notification",
          "body":
              "From ${SessionManager.instance.usersData["name"]} for a ride to $dropLocationAdd",
          "mutable_content": true,
          "sound": "Tri-tone"
        },
        "data": {
          "id": SessionManager.instance.usersData["id"],
          "first_name": SessionManager.instance.usersData["name"],
          "last_name": SessionManager.instance.usersData["last_name"],
          "pick_location": pickUpLocationAdd,
          "drop_location": dropLocationAdd,
          "image": SessionManager.instance.usersData["profile_picture"] ??
              'https://myride.dreamlabs.com.ng/assets/images/default-profile-picture.jpeg',
          "request_id": SessionManager.instance.userInstantData["request_place"]
              ["request_id"],
          "distance": DriversUtil.rounded.toString(),
          "drop_lat": dropLat,
          "drop_long": dropLong,
          "mobile": SessionManager.instance.usersData["mobile"],
          "cost_of_ride": costOfRide
        }
      });
      if (response != null && response.isNotEmpty) {
        setState(() {
          model.isPushChangeLocLoading = false;
        });
      } else {
        showErrorNotification(state!.context, response!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
    setState(() {
      model.isPushChangeLocLoading = false;
    });
  }

  void changeLocation() async {
    setState(() {
      model.isChangeLoading = true;
    });
    Response? response = await authRepo.changeLocation({
      'request_id': SessionManager.instance.userInstantData["request_place"]
          ["request_id"],
      'drop_lat': dropLat,
      'drop_lng': dropLong,
      'drop_address': dropLocationAdd,
    });

    if (response != null && response.statusCode == 200) {
      sendPushNotChangeLoc();
      setState(() {
        isChangeLocationOnTap = false;
      });
      Routers.replace(
          state!.context,
          MapScreen(
              fname: driverFname!,
              pickLocation: pickUpLocationAdd!,
              dropLocation: dropLocationAdd!));
      setState(() {
        model.isChangeLoading = true;
      });
    } else {
      showErrorNotification(state!.context, response!.data["message"]);
    }
    setState(() {
      model.isChangeLoading = true;
    });
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

  bool isChangeLoading = false;
  bool isPushChangeLocLoading = false;
}
