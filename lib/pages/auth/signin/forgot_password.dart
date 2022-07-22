import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../components/dismisskeyboard.dart';
import '../../../components/loading_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../controllers/auth_controller.dart';
import '../../../partials/mixins/validations.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword ({Key? key}) : super(key: key);

  @override
  State createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends StateMVC<ForgotPassword>
    with ValidationMixin {
  _ForgotPasswordState() : super(AuthController()) {
    con = controller as AuthController;
  }
  late AuthController con;

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
            child: DismissKeyboard(
              child: Form(
                key: con.model.forgotPasswordFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          'Enter your email address.',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextFormField(
                          focusNode: FocusNode(),
                          validator: validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          controller: con.model.forgotPasswordController,
                          decoration: Constants.inputDecoration.copyWith(
                            labelText: "Email Address",

                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 40, right: 0, left: 0),
                          child: LoadingButton(
                            isLoading: con.model.isForgotLoading,
                            label: (con.model.forgotPasswordFormKey.currentState
                                ?.validate() ==
                                true)
                                ? "Create Password"
                                : "Continue",
                            onPressed: con.forgotPassword,

                            /*   onPressed: (){
                                Routers.pushNamed(context, '/otp_page');} */
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}