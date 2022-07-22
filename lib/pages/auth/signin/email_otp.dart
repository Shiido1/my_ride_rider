import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../components/loading_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../controllers/auth_controller.dart';
import '../../../partials/mixins/validations.dart';

class EmailOtp extends StatefulWidget {
  const EmailOtp({Key? key}) : super(key: key);

  @override
  State createState() => _EmailOtpState();
}

class _EmailOtpState extends StateMVC<EmailOtp> with ValidationMixin {
  _EmailOtpState() : super(AuthController()) {
    con = controller as AuthController;
  }
  late AuthController con;
  String otpValue = "1234";
  String errorMsg = "enter 1234 to proceed";
  TextEditingController otpController = TextEditingController();
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
        padding: EdgeInsets.symmetric(horizontal:5.w, vertical: 5.w),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Adaptive.h(100) - 100,
            child: Form(
              key: con.model.emailOtpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly
                ,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OTP has been sent to your email',
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 30),

                      TextFormField(
                        validator: validateOTP_Test,
                        controller: con.model.emailOtpController,
                        decoration: Constants.defaultDecoration.copyWith(
                          labelText: "OTP",
                        ),
                      ),
                      SizedBox(height: 2.h),
                      TextButton(
                          onPressed: con.forgotPassword, child: const Text('Resend OTP')),
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
                          isLoading: con.model.isVerifyEmailOTPLoading,
                          label: "Continue",
                          onPressed: con.verifyEmailOTP,
                        ),
                      ),
                     SizedBox(height: 20.h),
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
}