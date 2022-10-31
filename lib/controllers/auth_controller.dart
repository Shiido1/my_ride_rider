import 'dart:convert';
import 'dart:developer';
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
import '../pages/auth/signin/signin.dart';
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
  String countryCode = "+1";
  final loadingKey = GlobalKey<FormState>();

  void sendPushNot() async {
    setState(() {
      model.isPushLoading = true;
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
        showDialog(
            context: state!.context,
            builder: (BuildContext context) {
              return const CustomRideDialog();
            });
        setState(() {
          model.isPushLoading = false;
        });
      } else {
        showErrorNotification(state!.context, response!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
    setState(() {
      model.isPushLoading = false;
    });
  }

  void signIn() async {
    if (model.loginFormKey.currentState?.validate() == true) {
      String? valueError;
      setState(() {
        model.isLoginLoading = true;
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
            model.isLoginLoading = false;
          });
        } else if (response!.data["errors"]["email"] != null) {
          for (int i = 0; i < response.data["errors"]["email"].length; i++) {
            if (response.data["errors"]["email"][i].toString().isNotEmpty) {
              valueError = response.data["errors"]["email"][i];
            }
          }
          showErrorNotificationWithCallback(state!.context, valueError ?? '');
        } else {
          showErrorNotification(state!.context, response.data!["message"]);
        }
      } catch (e, str) {
        debugPrint("Error: $e");
        debugPrint("StackTrace: $str");
      }
      setState(() {
        model.isLoginLoading = false;
      });
    }
  }

  void updateProfile() async {
    if (model.updateFormKey.currentState?.validate() == true) {
      setState(() {
        model.isUpdatingLoading = true;
      });

      try {
        Response? response = await authRepo.updateProfile({
          "email": SessionManager.instance.usersData["email"],
          "name":
              "${model.firstNameController.text} ${model.lastNameController.text}",
        });
        debugPrint("RESPONSE: $response");
        if (response != null && response.statusCode == 200) {
          getUserData();
          showSuccessNotification(
              state!.context, 'You have successfully updated your profile');
          Routers.replaceAllWithName(state!.context, '/home');
          setState(() {
            model.isUpdatingLoading = false;
          });
        }
      } catch (e, str) {
        debugPrint("Error: $e");
        debugPrint("StackTrace: $str");
      }
      setState(() {
        model.isUpdatingLoading = false;
      });
    }
  }

  void getUserDataWhenLogin() async {
    setState(() {
      model.isUserLoginLoading = true;
    });

    try {
      Map<String, dynamic>? response = await authRepo.getUserInfo();
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        Routers.replaceAllWithName(state!.context, '/initial_home');
        SessionManager.instance.usersData = response["data"];
      } else {
        showErrorNotification(state!.context, response!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
    setState(() {
      model.isUserLoginLoading = false;
    });
  }

  Future<void> getUserData() async {
    setState(() {
      model.isGetUserLoading = true;
    });

    try {
      Map<String, dynamic>? response = await authRepo.getUserInfo();
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        SessionManager.instance.usersData = response["data"];
        setState(() {
          model.isGetUserLoading = false;
        });
      } else {
        showErrorNotification(state!.context, response!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
    setState(() {
      model.isGetUserLoading = false;
    });
  }

  void signUp() async {
    String? valueError;
    if (model.regFormKey.currentState?.validate() == true) {
      setState(() {
        model.isSignUpLoading = true;
      });

      try {
        Response? response = await authRepo.register({
          "name":
              "${model.regFirstNameController.text} ${model.regLastNameController.text}",
          "last_name": model.regLastNameController.text,
          "email": model.regEmailController.text,
          "mobile": model.regPhoneNumberController.text,
          "device_token": deviceToken,
          "login_by": 'ios',
          "country": countryCode,
          "password": model.regPasswordController.text,
          "password_confirmation": model.regConfirmPassController.text,
          "state": model.regStateController.text,
          "city": model.regCityController.text,
          "zip_code": model.regZipCodeController.text,
        });

        if (response != null && response.statusCode == 200) {
          SessionManager.instance.authToken = response.data["access_token"];
          Routers.replaceAllWithName(state!.context, "/profile");
          setState(() {
            model.isSignUpLoading = false;
          });
        } else if (response!.data["errors"]["mobile"] != null) {
          for (int i = 0; i < response.data["errors"]["mobile"].length; i++) {
            if (response.data["errors"]["mobile"][i].toString().isNotEmpty) {
              valueError = response.data["errors"]["mobile"][i];
            }
          }
          showErrorNotificationWithCallback(state!.context, valueError ?? '');
        } else if (response.data["errors"]["email"] != null) {
          for (int i = 0; i < response.data["errors"]["email"].length; i++) {
            if (response.data["errors"]["email"][i].toString().isNotEmpty) {
              valueError = response.data["errors"]["email"][i];
            }
          }
          showErrorNotificationWithCallback(state!.context, valueError ?? '');
        } else if (response.data["errors"]["password"] != null) {
          for (int i = 0; i < response.data["errors"]["password"].length; i++) {
            if (response.data["errors"]["password"][i].toString().isNotEmpty) {
              valueError = response.data["errors"]["password"][i];
            }
            showErrorNotificationWithCallback(state!.context, valueError ?? '');
          }
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

      setState(() {
        model.isSignUpLoading = false;
      });
    }
  }

  void verifyOTP() async {
    if (model.otpFormKey.currentState?.validate() == true) {
      setState(() {
        model.isVerifyOTPLoading = true;
      });

      var uuid = SessionManager.instance.uuidData;

      Response? response = await authRepo
          .otpVerification({"otp": model.otpController.text, "uuid": uuid});

      if (response != null && response.statusCode == 200) {
        Navigator.pushNamed(state!.context, '/contact_info');
        setState(() {
          model.isVerifyOTPLoading = true;
        });
      } else {
        showErrorNotificationWithCallback(
            state!.context, response!.data["message"]);
        log(response.data);
      }

      setState(() {
        model.isVerifyOTPLoading = false;
      });
    }
  }

  void verifyEmailOTP() async {
    if (model.emailOtpFormKey.currentState?.validate() == true) {
      setState(() {
        model.isVerifyEmailOTPLoading = true;
      });

      var uuid = SessionManager.instance.uuidData;
      Response? response = await authRepo.emailOtpVerification(
          {"token": model.emailOtpController.text, "uuid": uuid});

      if (response != null && response.statusCode == 200) {
        var email = response.data["data"]["email"];
        SessionManager.instance.verifyEmail = email;
        Routers.pushNamed(state!.context, '/reset_password');
      } else {
        showErrorNotificationWithCallback(
            state!.context, response!.data["message"]);
      }

      setState(() {
        model.isVerifyEmailOTPLoading = false;
      });
    }
  }

  void resetPass() async {
    if (model.restPassFormKey.currentState?.validate() == true) {
      setState(() {
        model.isResetLoading = true;
      });
      Response? response = await authRepo.resetPassword({
        "password": model.resetPasswordController.text,
        "password_confirmation": model.resetConPassController.text,
        "email": SessionManager.instance.verifyEmail
      });
      if (response != null && response.statusCode == 200) {
        Routers.replace(state!.context, const SignInPage());
      } else {
        showErrorNotificationWithCallback(
            state!.context, response!.data["message"]);
      }

      setState(() {
        model.isResetLoading = false;
      });
    }
  }

  void forgotPassword() async {
    String? valueError;
    if (model.forgotPasswordFormKey.currentState?.validate() == true) {
      setState(() {
        model.isForgotLoading = true;
      });

      Response? response = await authRepo.forgotPassword({
        "email": model.forgotPasswordController.text,
      });
      if (response != null && response.statusCode == 200) {
        var uUId = response.data["data"]["uuid"];
        SessionManager.instance.uuidData = uUId;
        Routers.pushNamed(state!.context, '/email_otp');
      } else if (response!.data["errors"]["email"] != null) {
        for (int i = 0; i < response.data["errors"]["email"].length; i++) {
          if (response.data["errors"]["email"][i].toString().isNotEmpty) {
            valueError = response.data["errors"]["email"][i];
          }
        }
        showErrorNotificationWithCallback(state!.context, valueError ?? '');
      } else {
        showErrorNotificationWithCallback(
            state!.context, response.data["message"]);
      }

      setState(() {
        model.isForgotLoading = false;
      });
    }
  }

  void phoneVerification() async {
    if (model.insertPhoneFormKey.currentState?.validate() == true) {
      setState(() {
        model.isPhoneVerificationLoading = true;
      });

      Response? response = await authRepo.phoneVerification(
          {"mobile": model.insertPhoneController.text, "country": countryCode});
      if (response != null && response.statusCode == 200) {
        var uUid = response.data["data"]["uuid"];
        SessionManager.instance.uuidData = uUid;

        Navigator.pushNamed(state!.context, '/otp_page');
      } else {
        showErrorNotificationWithCallback(
            state!.context, response!.data["message"]);
      }

      setState(() {
        model.isPhoneVerificationLoading = false;
      });
    }
  }

  void instantTrip(Map map) async {
    setState(() {
      model.isInstantLoading = true;
    });
    var drivers = [map];
    print('buuuuug... ${map.toString()}');
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
      setState(() {
        model.isInstantLoading = false;
      });
      var instantData = response.data["data"];
      SessionManager.instance.userInstantData = instantData;
      sendPushNot();
    } else {
      showErrorNotificationWithCallback(
          state!.context, response!.data["message"]);
    }

    setState(() {
      model.isInstantLoading = false;
    });
  }

  void scheduleTrip(
      {List<String>? scheduleTripDate,
      String? schedulePeriod,
      String? vehicleType}) async {
    setState(() {
      model.isScheduleLoading = true;
    });
    Response? response = await authRepo.scheduleTrip({
      "pick_lat": pickUpLat,
      "pick_lng": pickUpLong,
      "drop_lat": dropLat,
      "drop_lng": dropLong,
      "vehicle_type": vehicleType,
      "payment_opt": "1",
      "pick_address": pickUpLocationAdd,
      "drop_address": dropLocationAdd,
      "is_later": 1,
      "trip_start_time": scheduleTripDate,
      "schedule_type": schedulePeriod
    });
    if (response != null && response.statusCode == 200) {
      Routers.replaceAllWithName(state!.context, "/home");
      showSuccessNotificationWithTime(
          state!.context, 'You\'ve Successfully scheduled a trip', 5);
      setState(() {
        model.isScheduleLoading = false;
      });
    } else {
      showErrorNotificationWithCallback(
          state!.context, response!.data["message"]);
    }

    setState(() {
      model.isScheduleLoading = false;
    });
  }

  void cancelTrip(context) async {
    setState(() {
      model.isCancelLoading = true;
    });
    Response? response = await authRepo.cancelTrip({
      'request_id': SessionManager.instance.userInstantData["request_place"]
          ["request_id"],
      'custom_reason': 'for some reason'
    });

    if (response != null && response.statusCode == 200) {
      await up(path: id, status: "Idle");
      Routers.replaceAllWithName(context, '/home');
    } else {
      showErrorNotificationWithCallback(
          state!.context, response!.data!["message"]);
    }
    setState(() {
      model.isCancelLoading = false;
    });
  }

  void ratings(context, {String? rate, String? comment}) async {
    setState(() {
      model.isRatingLoading = true;
    });
    Response? response = await authRepo.ratings({
      'request_id': SessionManager.instance.userInstantData["request_place"]
          ["request_id"],
      'rating': rate,
      'comment': comment,
    });

    if (response != null && response.statusCode == 200) {
      Routers.replaceAllWithName(context, '/home');
      showSuccessNotificationWithTime(
          state!.context, response.data['message'], 3);
      setState(() {
        model.isRatingLoading = false;
      });
    } else {
      showErrorNotificationWithCallback(
          state!.context, response!.data!["message"]);
    }
    setState(() {
      model.isRatingLoading = false;
    });
  }

  void signOut(BuildContext context) async {
    await SessionManager.instance.logOut();

    Routers.replaceAllWithName(context, '/signin');
  }

  _formatFileImage(File? imageFile) {
    if (imageFile == null) return;
    return File(imageFile.path.replaceAll('\'', '').replaceAll('File: ', ''));
  }

  void getUserProfileData({File? image, BuildContext? context}) async {
    setState(() {
      model.isUserProfileLoading = true;
    });
    try {
      UserDialog.showLoading(context!, loadingKey);
      Map<String, dynamic>? response = await authRepo.profilePicture({
        "profile_picture": MultipartFile.fromBytes(
            _formatFileImage(image).readAsBytesSync(),
            filename: image!.path.split("/").last)
      });
      if (response != null && response.isNotEmpty) {
        getUserData();
        UserDialog.hideLoading(loadingKey);
      } else {
        showErrorNotificationWithCallback(state!.context, response!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
    setState(() {
      model.isUserProfileLoading = false;
    });
  }
}
