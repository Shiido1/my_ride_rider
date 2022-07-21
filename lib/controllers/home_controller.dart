import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/repository/auth_repo.dart';
import '../utils/Flushbar_mixin.dart';

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
