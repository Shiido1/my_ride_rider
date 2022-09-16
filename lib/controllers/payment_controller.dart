import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/utils/Flushbar_mixin.dart';
import 'package:my_ride/utils/router.dart';
import '../constants/session_manager.dart';
import '../models/card_models.dart';
import '../models/global_model.dart';
import '../repository/auth_repo.dart';
import '../widget/map_screen.dart';

class PaymentController extends ControllerMVC with FlushBarMixin {
  factory PaymentController([StateMVC? state]) =>
      _this ??= PaymentController._(state);
  final logger = Logger();

  PaymentController._(StateMVC? state)
      : model = CardModel(),
        super(state);
  static PaymentController? _this;

  final CardModel model;

  final AuthRepo paymentRepo = AuthRepo();

  void addCard() async {
    if (model.cardFormKey.currentState?.validate() == true) {
      setState(() {
        model.isCardLoading = true;
      });

      try {
        Response? response = await paymentRepo.addCard({
          "card_number": model.cardNoController.text,
          "exp_month": model.monthController.text,
          "cvc": model.cvvController.text,
          "exp_year": model.yearController.text
        });
        if (response != null && response.statusCode == 200) {
          SessionManager.instance.isAddCard = true;
          // if (isRegistration == true) {
          //   Routers.replaceAllWithName(state!.context, "/reg_success");
          // } else {
            Routers.replace(
                state!.context,
                MapScreen(
                    fname: driverFname!,
                    pickLocation: pickUpLocationAdd!,
                    dropLocation: dropLocationAdd!));
          // }
        } else {
          showErrorNotificationWithCallback(
              state!.context, response!.data!["message"] ?? '');
        }
      } catch (e, str) {
        debugPrint("Error: $e");
        debugPrint("StackTrace: $str");
      }
      cardno = model.cardNoController.text;
      year = model.yearController.text;
      cvv = model.cvvController.text;
      month = model.monthController.text;

      setState(() {
        model.isCardLoading = false;
      });
    }
  }

  Future<void> getUserData() async {
    setState(() {
      model.isGetUserLoading = true;
    });

    try {
      Map<String, dynamic>? response = await paymentRepo.getUserInfo();
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        SessionManager.instance.usersData = response["data"];
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
}
