import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/profile_model.dart';

class ProfileController extends ControllerMVC {
  factory ProfileController([StateMVC? state]) => _this ??= ProfileController._(state);
  ProfileController._(StateMVC? state)
      : model = ProfileModel(),
        super(state);
  static ProfileController? _this;

  final ProfileModel model;

  
}
