import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/profile_model.dart';
import 'package:my_ride/utils/users_dialog.dart';

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
}
//   final loadingKey = GlobalKey<FormState>();

//   _formartFileImage(File? imageFile) {
//     if (imageFile == null) return;
//     return File(imageFile.path.replaceAll('\'', '').replaceAll('File: ', ''));
//   }

//   void getUserProfileData({File? image, BuildContext? context}) async {
//     setState(() {
//       model.isLoading = true;
//     });
//     try {
//       UserDialog.showLoading(context!, loadingKey);
//       Map<String, dynamic>? response = await authRepo.profilePicture({
//         "profile_picture": MultipartFile.fromBytes(
//             _formartFileImage(image).readAsBytesSync(),
//             filename: image!.path.split("/").last)
//       });
//       debugPrint("RESPONSE: $response");
//       if (response != null && response.isNotEmpty) {
//         // SessionManager.instance.usersProfileData = response["data"];
//         getUserData();
//         UserDialog.hideLoading(loadingKey);
//       } else {
//         showErrorNotification(state!.context, response!["message"]);
//       }
//     } catch (e, str) {
//       debugPrint("Error: $e");
//       debugPrint("StackTrace: $str");
//     }
//     setState(() {
//       model.isLoading = false;
//     });
//   }

//   void getUserData() async {

//     try {
//       Map<String, dynamic>? response = await authRepo.getUserInfo();
//       debugPrint("RESPONSE: $response");
//       if (response != null && response.isNotEmpty) {
//         SessionManager.instance.usersData = response["data"];
//       } else {
//         showErrorNotification(state!.context, response!["message"]);
//       }
//     } catch (e, str) {
//       debugPrint("Error: $e");
//       debugPrint("StackTrace: $str");
//     }
//   }
// }
