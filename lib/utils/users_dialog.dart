import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/colors.dart';

class UserDialog {
  static void showLoading(BuildContext context, GlobalKey key,
      [String message = 'Loading...']) async {
    final dialog = Dialog(
      key: key,
      backgroundColor: AppColors.transparent,
      elevation: 0,
      child: SpinKitFadingCircle(color: AppColors.primary, size: 30.sp),
    );

    await showDialog(
      context: context,
      barrierColor: AppColors.transparent,
      builder: (BuildContext context) => dialog,
      barrierDismissible: false,
    );
  }

  static void hideLoading(GlobalKey key) {
    if (key.currentContext != null) {
      Navigator.of(key.currentContext!, rootNavigator: true).pop();
    } else {
      Future.delayed(const Duration(milliseconds: 300)).then((value) =>
          Navigator.of(key.currentContext!, rootNavigator: true).pop());
    }
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    void Function()? onClose,
    bool error = false,
  }) {
    final snackBar = SnackBar(
      content: TextView(
        text: message,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: !error ? AppColors.primary : Colors.red,
      duration: const Duration(seconds: 10),
      action: SnackBarAction(
        label: 'CLOSE',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (onClose != null) {
            onClose();
          }
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
