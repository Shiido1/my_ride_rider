import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/widget/text_widget.dart';

mixin FlushBarMixin {
  void showSuccessNotification(BuildContext context, String? message) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Flushbar(
        message: message,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.green[300],
        ),
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: Colors.green[300],
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    });
  }

  void showSuccessNotificationWithTime(
      BuildContext context, String? message, int timeInSeconds) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Flushbar(
              message: message,
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.green[300],
              ),
              duration: Duration(seconds: timeInSeconds),
              leftBarIndicatorColor: Colors.green[300],
              flushbarPosition: FlushbarPosition.BOTTOM)
          .show(context);
    });
  }

  void showErrorNotification(BuildContext context, String? message) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Flushbar(
        message: message,
        messageText: Text("$message"),
        userInputForm: Form(
            child: TextView(
          text: "$message",
          color: AppColors.white,
        )),
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red[300],
        ),
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: Colors.red[300],
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    });
  }

  void showErrorNotificationWithCallback(BuildContext context, String message,
      {Function? callback}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Flushbar(
        message: message,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red[300],
        ),
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: Colors.red[300],
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context).then((value) {
        callback!();
      });
    });
  }

  void showSuccessNotificationWithCallback(BuildContext context, String message,
      {Function? callback}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // ignore: avoid_single_cascade_in_expression_statements
      Flushbar(
        message: message,
        icon: Icon(
          Icons.check_box_outlined,
          size: 28.0,
          color: Colors.green[300],
        ),
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: Colors.green[300],
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context).then((value) {
          callback!();
        });
    });
  }

  void showSuccessNotificationWithTimerAndCallback(
      BuildContext context, String message,
      {Function? callback, int timeInSeconds = 1}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // ignore: avoid_single_cascade_in_expression_statements
      Flushbar(
        message: message,
        icon: Icon(
          Icons.check_box_outlined,
          size: 28.0,
          color: Colors.green[300],
        ),
        duration: Duration(seconds: timeInSeconds),
        leftBarIndicatorColor: Colors.green[300],
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context).then((value) {
          callback!();
        });
    });
  }

  void showErrorNotificationWithTime(
      BuildContext context, String message, int timeInSeconds) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Flushbar(
        message: message,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red[300],
        ),
        duration: Duration(seconds: timeInSeconds),
        leftBarIndicatorColor: Colors.red[300],
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    });
  }

  void showInfoNotification(BuildContext context, String? message) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Flushbar(
        message: message,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.yellow[700],
        ),
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: Colors.yellow[700],
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    });
  }
}
