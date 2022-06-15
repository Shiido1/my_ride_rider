import 'package:flutter/material.dart';
import 'package:my_ride/constants/colors.dart';

class AppBackButton extends StatelessWidget {
  final Function()? onPressed;
  const AppBackButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary,));
  }
}