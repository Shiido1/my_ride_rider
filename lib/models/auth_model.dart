import 'package:flutter/material.dart';

class AuthModel {
  //Sign in
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  ///sign up
  final TextEditingController regFirstNameController = TextEditingController();
  final TextEditingController regLastNameController = TextEditingController();
  final TextEditingController regPhoneNumberController = TextEditingController();
  final TextEditingController regEmailController = TextEditingController();
  final TextEditingController regPasswordController = TextEditingController();
  final TextEditingController regConfirmPassController = TextEditingController();
  final TextEditingController regdeviceTypeController = TextEditingController();
  final GlobalKey<FormState> regFormKey = GlobalKey<FormState>();

 //insert phone
  final TextEditingController insertPhoneController = TextEditingController();
  final GlobalKey<FormState> insertPhoneFormKey = GlobalKey<FormState>();
  bool isLoading = false;

 //otp
  final TextEditingController otpController = TextEditingController();

  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
}

class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});
}
