import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/repository/auth_repo.dart';
import '../constants/session_manager.dart';
import '../utils/Flushbar_mixin.dart';
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
}
