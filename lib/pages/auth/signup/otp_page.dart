import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_ride/components/loading_button.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/constants/constants.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:my_ride/partials/mixins/validations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../widget/text_widget.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State createState() => _OTPPageState();
}

class _OTPPageState extends StateMVC<OTPPage> with ValidationMixin {
  _OTPPageState() : super(AuthController()) {
    con = controller as AuthController;
  }
  late AuthController con;
  String otpValue = "1234";
  String errorMssg = "enter 1234 to proceed";
  TextEditingController otpController = TextEditingController();
  Timer? _timer;
  LoadingButton? loadingButton;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const SizedBox(),
          elevation: 0,
          backgroundColor: Colors.transparent),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5), vertical: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Adaptive.h(100) - 100,
            child: Form(
              key: con.model.otpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: 'OTP has been sent to your number',
                        fontSize: 18.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        validator: validateOTP_Test,
                        controller: con.model.otpController,
                        decoration: Constants.defaultDecoration.copyWith(
                          labelText: "OTP",
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextButton(
                          onPressed: () {}, child: const Text('Resend OTP')),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 40,
                            right: Adaptive.w(15),
                            left: Adaptive.w(15)),
                        child: LoadingButton(
                          isLoading: con.model.isVerifyOTPLoading,
                          label: "Continue",
                          onPressed: con.verifyOTP,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void delayforthresec() {
    _timer = Timer(const Duration(milliseconds: 400), () {
      setState(() {
        loadingButton?.isLoading = true;
      });
    });
  }
}
