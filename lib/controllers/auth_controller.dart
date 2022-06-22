import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/auth_model.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/repository/auth_repo.dart';
import 'package:my_ride/utils/Flushbar_mixin.dart';
import 'package:my_ride/utils/local_storage.dart';
import 'package:my_ride/utils/router.dart';
import '../components/reg_model.dart';

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
        "to":token,
        "notification": {
          "pick_up": pickUpLocationAdd,
          "drop": dropLocationAdd,
          "mutable_content": true,
          "sound": "Tri-tone"
        },
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
          "login_by": model.regdeviceTypeController.text,
          "country": countryCode,
          "password": model.regPasswordController.text,
          "password_confirmation": model.regConfirmPassController.text
        });

        if (response != null && response.isNotEmpty) {
          LocalStorage().store("token", response['access_token']);
          LocalStorage().store("refreshToken", response["refresh_token"]);

          Routers.replaceAllWithName(state!.context, "/profile");
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

      var uuid = await LocalStorage().fetch("userid");

      print(uuid);

      Map<String, dynamic>? response =
          await authRepo.otpVerification({"otp": otpValue, "uuid": uuid});

      print(response);
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
      print(response);
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
    LocalStorage().store("token", "");

    Routers.replaceAllWithName(context, '/signin');
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
