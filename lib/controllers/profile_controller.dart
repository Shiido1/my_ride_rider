import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/profile_model.dart';

import '../components/reg_model.dart';
import '../constants/session_manager.dart';
import '../repository/auth_repo.dart';
import '../utils/Flushbar_mixin.dart';

class ProfileController extends ControllerMVC with FlushBarMixin {
  BuildContext? context;
  factory ProfileController([StateMVC? state]) =>
      _this ??= ProfileController._(state);
  ProfileController._(StateMVC? state)
      : model = ProfileModel(),
        super(state);
  static ProfileController? _this;

  final ProfileModel model;
  final AuthRepo authRepo = AuthRepo();

  _formartFileImage(File? imageFile) {
    if (imageFile == null) return;
    return File(imageFile.path.replaceAll('\'', '').replaceAll('File: ', ''));
  }

  void getUserProfileData({File? image}) async {
    setState(() {
      model.isLoading = true;
    });
    try {
      Map<String, dynamic>? response = await authRepo.profilePicture({
        "profile_picture": MultipartFile.fromBytes(
            _formartFileImage(image).readAsBytesSync(),
            filename: image!.path.split("/").last)
      });
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        SessionManager.instance.usersProfileData = response["data"];
        print(
            'object printitng profileimage ${SessionManager.instance.usersProfileData["profile_picture"]}');
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
}
