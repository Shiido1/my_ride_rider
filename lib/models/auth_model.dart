import 'package:flutter/material.dart';
import 'package:my_ride/models/global_model.dart';

class AuthModel {
  //Sign in
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();

  ///sign up
  final TextEditingController regFirstNameController = TextEditingController();
  final TextEditingController regLastNameController = TextEditingController();
  final TextEditingController regPhoneNumberController =
      TextEditingController();
  final TextEditingController regEmailController = TextEditingController();
  final TextEditingController regPasswordController = TextEditingController();
  final TextEditingController regConfirmPassController =
      TextEditingController();
  final TextEditingController regDeviceTypeController = TextEditingController();


  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController forgotPasswordController = TextEditingController();
  // email otp
  final TextEditingController emailOtpController = TextEditingController();
  GlobalKey<FormState> emailOtpFormKey = GlobalKey<FormState>();
  // reset password
  GlobalKey<FormState> restPassFormKey = GlobalKey<FormState>();
  final TextEditingController resetPasswordController = TextEditingController();
  final TextEditingController resetConPassController = TextEditingController();

  TextEditingController destinationController =
      TextEditingController(text: dropLocationAdd);

  TextEditingController pickupController =
      TextEditingController(text: pickUpLocationAdd);
  final GlobalKey<FormState> regFormKey = GlobalKey<FormState>();

  //insert phone
  final TextEditingController insertPhoneController = TextEditingController();
  final GlobalKey<FormState> insertPhoneFormKey = GlobalKey<FormState>();
  bool isLoginLoading = false;
  bool isUpdatingLoading = false;
  bool isPushLoading = false;
  bool isUserLoginLoading = false;
  bool isGetUserLoading = false;
  bool isSignUpLoading = false;
  bool isVerifyOTPLoading = false;
  bool isVerifyEmailOTPLoading = false;
  bool isResetLoading = false;
  bool isForgotLoading = false;
  bool isPhoneVerificationLoading = false;
  bool isInstantLoading = false;
  bool isScheduleLoading = false;
  bool isCancelLoading = false;
  bool isRatingLoading = false;
  bool isUserProfileLoading = false;


  //otp
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  /// model for profile
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailProfileController = TextEditingController();
  final TextEditingController passwordProfileController =
      TextEditingController();
  final TextEditingController phoneVersionController = TextEditingController();
  final TextEditingController deviceTokenController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyEdit = GlobalKey<FormState>();

  bool isProfileLoading = false;
  bool isEditable = false;
}

class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});
}
