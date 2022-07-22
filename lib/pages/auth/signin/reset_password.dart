import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../components/loading_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../controllers/auth_controller.dart';
import '../../../partials/mixins/validations.dart';
import '../../../widget/text_widget.dart';



class ResetPassword extends StatefulWidget {
  const ResetPassword ({Key? key}) : super(key: key);

  @override
  State createState() => _ResetPasswordState();
}

class _ResetPasswordState extends StateMVC<ResetPassword> with ValidationMixin {
  _ResetPasswordState() : super(AuthController()) {
    con = controller as AuthController;
  }
  late AuthController con;

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
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Adaptive.h(100) - 100,
            child: Form(
              key: con.model.restPassFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text:'Reset your password',

                          fontSize: 20.sp,
                          color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 10.h),

                      TextFormField(
                        obscureText: true,
                        validator: validatePassword,
                        controller: con.model.resetPasswordController,
                        decoration: Constants.defaultDecoration.copyWith(
                          labelText: "Password",
                        ),
                      ),
                     SizedBox(height: 5.h,),
                      TextFormField(
                        obscureText: true,
                        validator: validatePassword,
                        controller: con.model.resetConPassController,
                        decoration: Constants.defaultDecoration.copyWith(
                          labelText: "Confirm password",
                        ),
                      ),
                     SizedBox(height: 5.h),

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
                          isLoading: con.model.isResetLoading,
                          label: "Reset password",
                          onPressed: con.resetPass,
                        ),
                      ),
                     SizedBox(height: 9.h),
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