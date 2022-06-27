import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/auth_model.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/repository/auth_repo.dart';
import 'package:my_ride/utils/Flushbar_mixin.dart';
import 'package:my_ride/utils/local_storage.dart';
import 'package:my_ride/utils/router.dart';
import '../components/reg_model.dart';
import '../constants/session_manager.dart';

class AuthController extends ControllerMVC with FlushBarMixin {
  BuildContext? context;

  factory AuthController([StateMVC? state]) =>
      _this ??= AuthController._(state);
  AuthController._(StateMVC? state)
      : model = AuthModel(),
        super(state);
  static AuthController? _this;

  final AuthModel model;

  final AuthRepo authRepo = AuthRepo();
  String deviceToken = "DeviceTokin";
  String countryCode = "+234";
  String otpValue = "1234";

  void sendPushNot({String? token}) async {
    setState(() {
      model.isLoading = true;
    });

    try {
      Map<String, dynamic>? response = await authRepo.sendPushNot({
        "to": token,
        "notification": {
          "title": "title",
          "body": "body",
          "mutable_content": true,
          "sound": "Tri-tone"
        },
        "data": {
          "first_name": SessionManager.instance.usersData["name"],
          "last_name": SessionManager.instance.usersData["last_name"],
          "pick_location": pickUpLocationAdd,
          "drop_location": dropLocationAdd,
          "image":
              "https://myride.dreamlabs.com.ng/storage/uploads/user/profile-picture/${SessionManager.instance.usersData["profile_picture"]}",
        }
      });
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        print('print res $response');
        debugPrint("response not null: $response");
        {
          LocalStorage().store("token", response['access_token']);
        }
        Routers.replaceAllWithName(state!.context, '/home');
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

  void signIn() async {
    setState(() {
      model.isLoading = true;
    });

    try {
      Map<String, dynamic>? response = await authRepo.login({
        "email": model.emailController.text,
        "password": model.passwordController.text
      });
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        SessionManager.instance.isLoggedIn = true;
        SessionManager.instance.authToken = response["access_token"];
        getUserData();
        // Routers.replaceAllWithName(state!.context, '/home');
        setState(() {
          model.isLoading = false;
        });
      } else {
        showErrorNotification(state!.context, response!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
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
        Routers.replaceAllWithName(state!.context, '/home');
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

  void signUp() async {
    if (model.regFormKey.currentState?.validate() == true) {
      setState(() {
        model.isLoading = true;
      });

      try {
        Map<String, dynamic>? response = await authRepo.register({
          "name": model.regFirstNameController.text,
          "last_name": model.regLastNameController.text,
          "email": model.regEmailController.text,
          "mobile": model.regPhoneNumberController.text,
          "device_token": deviceToken,
          "login_by": 'ios',
          "country": countryCode,
          "password": model.regPasswordController.text,
          "password_confirmation": model.regConfirmPassController.text
        });

        if (response != null && response.isNotEmpty) {
          SessionManager.instance.authToken = response["access_token"];
          Routers.replaceAllWithName(state!.context, "/profile");
          setState(() {
            model.isLoading = false;
          });
        } else {
          showErrorNotification(state!.context, response!["message"]);
        }
      } catch (e, str) {
        debugPrint("Error: $e");
        debugPrint("StackTrace: $str");
      }
      firstNam = model.regFirstNameController.text;
      lastNam = model.regLastNameController.text;
      phoneNum = model.regPhoneNumberController.text;
      email = model.regEmailController.text;
      passwordNam = model.regEmailController.text;

      // setState(() {
      //   model.isLoading = false;
      // });
    }
  }

  void verifyOTP() async {
    if (model.otpFormKey.currentState?.validate() == true) {
      setState(() {
        model.isLoading = true;
      });

      var uuid = await LocalStorage().fetch("userid");

      Map<String, dynamic>? response =
          await authRepo.otpVerification({"otp": otpValue, "uuid": uuid});

      if (response != null && response["message"] == "success") {
        Navigator.pushNamed(state!.context, '/contact_info');
      } else {
        showErrorNotification(state!.context, response!["message"]);
      }

      setState(() {
        model.isLoading = false;
      });
    }
  }

  void phoneVerification() async {
    if (model.insertPhoneFormKey.currentState?.validate() == true) {
      setState(() {
        model.isLoading = true;
      });

      Map<String, dynamic>? response = await authRepo.phoneVerification(
          {"mobile": model.insertPhoneController.text, "country": countryCode});
      if (response != null && response["message"] == "success") {
        var uUid = response["data"]["uuid"];
        LocalStorage().store("userid", uUid);

        Navigator.pushNamed(state!.context, '/otp_page');
      } else {
        showErrorNotification(state!.context, response!["message"]);
      }

      setState(() {
        model.isLoading = false;
      });
    }
  }

  void signOut(BuildContext context) async {
    await SessionManager.instance.logOut();

    Routers.replaceAllWithName(context, '/signin');
  }

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

class Data {
  String? uuid;

  Data({this.uuid});

  Data.fromJson(Map<String, dynamic> json) {
    Data(
      uuid: json["uuid"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"uuid": uuid};
  }
}
