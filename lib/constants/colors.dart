import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0XFF150D40);
  static const Color orange = Color(0XFFF79837);
  static const Color secondary = Color(0XFF27BC80);
  static const Color greyWhite = Color(0XFFF7F7F7);
  static const Color bgGrey1 = Color(0XFFCACACA);


  static const Color textGreen10 = Color(0XFF129A67);
}

extension ColorExt  on Color {
  Color disable(bool? status) {
    if(status != null && !status) {
      return this;
    }

    return withOpacity(0.5);
  }
}