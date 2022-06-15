import 'package:flutter/material.dart';
import 'package:my_ride/constants/colors.dart';

class MyAppBar {
  static PreferredSizeWidget? defaultAppBar(BuildContext context){
    return AppBar(
       leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary,)),
       backgroundColor: Colors.transparent,
       elevation: 0,
      );
  }
}