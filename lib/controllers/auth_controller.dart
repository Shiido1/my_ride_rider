import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/auth_model.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/repository/auth_repo.dart';
import 'package:my_ride/utils/Flushbar_mixin.dart';
import 'package:my_ride/utils/driver_utils.dart';
import 'package:my_ride/utils/router.dart';
import '../components/reg_model.dart';
import '../constants/session_manager.dart';
import '../utils/users_dialog.dart';
import '../widget/custom_waiting_widget.dart';

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
  final loadingKey = GlobalKey<FormState>();

  void sendPushNot() async {
    setState(() {
      model.isLoading = true;
    });

    try {
      Map<String, dynamic>? response = await authRepo.sendPushNot({
        "to": token,
        "notification": {
          "title": "You'\ve just received a notification",
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
          "image":
              "https://myride.dreamlabs.com.ng/storage/uploads/user/profile-picture/${SessionManager.instance.usersData["profile_picture"]}",
          "request_id": SessionManager.instance.userInstantData["request_place"]
              ["request_id"],
          "distance": DriversUtil.rounded.toString(),
          "drop_lat": dropLat,
          "drop_long": dropLong,
        }
      });
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        showDialog(
            context: state!.context,
            builder: (BuildContext cntxt) {
              return const CustomRideDialog();
            });
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
      Response? response = await authRepo.login({
        "email": model.emailController.text,
        "password": model.passwordController.text
      });
      debugPrint("RESPONSE: $response");
      if (response != null && response.statusCode == 200) {
        SessionManager.instance.isLoggedIn = true;
        SessionManager.instance.authToken = response.data["access_token"];
        getUserDataWhenLogin();
        setState(() {
          model.isLoading = false;
        });
      } else {
        showErrorNotification(state!.context, response!.data!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
    setState(() {
      model.isLoading = false;
    });
  }

  void getUserDataWhenLogin() async {
    setState(() {
      model.isLoading = true;
    });

    try {
      Map<String, dynamic>? response = await authRepo.getUserInfo();
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        SessionManager.instance.usersData = response["data"];
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

  void getUserData() async {
    setState(() {
      model.isLoading = true;
    });

    try {
      Map<String, dynamic>? response = await authRepo.getUserInfo();
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        print('how response looks like $response');
        SessionManager.instance.usersData = response["data"];
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
        Response? response = await authRepo.register({
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

        if (response != null && response.statusCode == 200) {
          SessionManager.instance.authToken = response.data["access_token"];
          Routers.replaceAllWithName(state!.context, "/profile");
          setState(() {
            model.isLoading = false;
          });
        } else {
          
          String? valueError;
          for (int i = 0; i < response!.data["errors"]["email"].length; i++) {
            if(response.data["errors"]["email"][i].toString().isNotEmpty) {
              valueError = response.data["errors"]["email"][i];
            }else{
              valueError = response.data["errors"]["mobile"][i];
            }
          }
          print('error $valueError');
          showErrorNotificationWithCallback(state!.context, valueError ?? '');
        }
      } catch (e, str) {
        print('object response $e');
        debugPrint("Error: $e");
        debugPrint("StackTrace: $str");
      }
      firstNam = model.regFirstNameController.text;
      lastNam = model.regLastNameController.text;
      phoneNum = model.regPhoneNumberController.text;
      email = model.regEmailController.text;
      passwordNam = model.regEmailController.text;

      setState(() {
        model.isLoading = false;
      });
    }
  }

  void verifyOTP() async {
    if (model.otpFormKey.currentState?.validate() == true) {
      setState(() {
        model.isLoading = true;
      });

      var uuid = SessionManager.instance.uuidData;

      Response? response =
          await authRepo.otpVerification({"otp": otpValue, "uuid": uuid});

      if (response != null && response.statusCode == 200) {
        Navigator.pushNamed(state!.context, '/contact_info');
      } else {
        showErrorNotification(state!.context, response!.data["message"]);
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

      Response? response = await authRepo.phoneVerification(
          {"mobile": model.insertPhoneController.text, "country": countryCode});
      if (response != null && response.statusCode == 200) {
        var uUid = response.data["data"]["uuid"];
        // LocalStorage().store("userid", uUid);
        SessionManager.instance.uuidData = uUid;

        Navigator.pushNamed(state!.context, '/otp_page');
      } else {
        showErrorNotification(state!.context, response!.data["message"]);
      }

      setState(() {
        model.isLoading = false;
      });
    }
  }

  void instantTrip(Map map) async {
    var drivers = [map];
    Response? response = await authRepo.instantTrip({
      "pick_lat": pickUpLat,
      "pick_lng": pickUpLong,
      "drop_lat": dropLat,
      "drop_lng": dropLong,
      "vehicle_type": "eb7d7a67-b710-450a-b1c8-d52a8d0db8eb",
      "payment_opt": "1",
      "schedule_type": "instant",
      "pick_address": pickUpLocationAdd,
      "drop_address": dropLocationAdd,
      "driver": jsonEncode(drivers)
    });
    if (response != null && response.statusCode == 200) {
      print('trip is successful my nigga');

      var instantData = response.data["data"];
      SessionManager.instance.userInstantData = instantData;
      sendPushNot();
    } else {
      showErrorNotification(state!.context, response!.data["message"]);
    }

    setState(() {
      model.isLoading = false;
    });
  }

  void scheduleTrip({String? scheduleTripDate, String? schedulePeriod}) async {
    setState(() {
      model.isLoading = true;
    });
    Response? response = await authRepo.scheduleTrip({
      "pick_lat": pickUpLat,
      "pick_lng": pickUpLong,
      "drop_lat": dropLat,
      "drop_lng": dropLong,
      "vehicle_type": "eb7d7a67-b710-450a-b1c8-d52a8d0db8eb",
      "payment_opt": "1",
      "pick_address": pickUpLocationAdd,
      "drop_address": dropLocationAdd,
      "is_later": 1,
      "trip_start_time": scheduleTripDate,
      "schedule_type":
          schedulePeriod // Can be instant, weekly, bi-weekly or monthly
      // "promocode_id": ""
    });
    if (response != null && response.statusCode == 200) {
      // var instantData = response["data"];
      Routers.replaceAllWithName(state!.context, "/home");
      showSuccessNotificationWithTime(
          state!.context, 'You\'ve Successfully scheduled a trip', 5);
      setState(() {
        model.isLoading = false;
      });
    } else {
      showErrorNotification(state!.context, response!.data["message"]);
    }

    setState(() {
      model.isLoading = false;
    });
  }

  void payment(
      {String? cardNo, String? exMonth, String? exYear, String? cvc}) async {
    setState(() {
      model.isLoading = true;
    });
    Response? response = await authRepo.payment({
      "card_number": cardNo,
      "exp_month": exMonth,
      "exp_year": exYear,
      "cvc": cvc
    });
    if (response != null &&
        response.data["success"] == 'Payment Method Added Successfully') {
      Routers.replaceAllWithName(state!.context, "/ratings");
      showSuccessNotificationWithTime(
          state!.context, ' Your Payment is Successfully', 5);
      setState(() {
        model.isLoading = false;
      });
    } else {
      showErrorNotification(state!.context, response!.data!["message"]);
    }

    setState(() {
      model.isLoading = false;
    });
  }

  void cancelTrip(context) async {
    Response? response = await authRepo.cancelTrip({
      'request_id': SessionManager.instance.userInstantData["data"]
          ["request_place"]["request_id"],
      'custom_reason': 'for some reason'
    });

    if (response != null && response.statusCode == 200) {
      print('cancel is successful my nigga');
      Routers.replaceAllWithName(context, '/home');
    } else {
      showErrorNotification(state!.context, response!.data!["message"]);
    }
  }

  void changeLocation() async {
    Response? response = await authRepo.changeLocation({
      'request_id': SessionManager.instance.userInstantData["data"]
          ["request_place"]["request_id"],
      'drop_lat': dropLat,
      'drop_lng': dropLong,
      'drop_address': dropLocationAdd,
    });

    if (response != null && response.statusCode == 200) {
      print('location changed is successful my nigga');
    } else {
      showErrorNotification(state!.context, response!.data["message"]);
    }
  }

  void ratings(context, {String? rate, String? comment}) async {
    Response? response = await authRepo.cancelTrip({
      'request_id': SessionManager.instance.userInstantData["data"]
          ["request_place"]["request_id"],
      'rating': rate,
      'comment': comment,
    });

    if (response != null && response.statusCode == 200) {
      print('rating is successful my nigga');
      Routers.replaceAllWithName(context, '/home');
    } else {
      showErrorNotification(state!.context, response!.data!["message"]);
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

  void getUserProfileData({File? image, BuildContext? context}) async {
    setState(() {
      model.isLoading = true;
    });
    try {
      UserDialog.showLoading(context!, loadingKey);
      Map<String, dynamic>? response = await authRepo.profilePicture({
        "profile_picture": MultipartFile.fromBytes(
            _formartFileImage(image).readAsBytesSync(),
            filename: image!.path.split("/").last)
      });
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        getUserData();
        UserDialog.hideLoading(loadingKey);
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
