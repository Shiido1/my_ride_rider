import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0XFF150D40);
  static const Color black = Colors.black;
  static const Color orange = Color(0XFFF79837);
  static const Color secondary = Color(0XFF27BC80);
  static const Color greyWhite = Color(0XFFF7F7F7);
  static const Color greyWhite1 = Color.fromARGB(255, 248, 246, 246);
  static const Color bgGrey1 = Color(0XFFCACACA);
  static const Color red = Colors.red;
  static const Color white = Color(0XFFffffff);
  static const Color transparent = Colors.transparent;
  static const Color grey1 = Color.fromARGB(255, 118, 115, 115);
  static const Color grey2 = Color.fromARGB(255, 242, 241, 241);
  static const Color green = Color.fromARGB(255, 18, 180, 7);
  static const Color yellow = Color.fromARGB(255, 239, 220, 8);

  static const Color textGreen10 = Color(0XFF129A67);
}

extension ColorExt on Color {
  Color disable(bool? status) {
    if (status != null && !status) {
      return this;
    }

    return withOpacity(0.5);
  }
}
