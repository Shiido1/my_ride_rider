import 'package:flutter/material.dart';
import 'package:my_ride/components/loading_button.dart';
import 'package:my_ride/components/dismisskeyboard.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/constants/constants.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:my_ride/partials/mixins/validations.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({Key? key}) : super(key: key);

  @override
  State createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends StateMVC<PhoneNumberPage>
    with ValidationMixin {
  _PhoneNumberPageState() : super(AuthController()) {
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
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5), vertical: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Adaptive.h(100) - 100,
            child: DismissKeyboard(
              child: Form(
                key: con.model.insertPhoneFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text:'Get Started',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          
                        ),
                        SizedBox(height: 3.h),
                        TextView(
                          text:'Enter your phone number.',
                            fontSize: 17.sp,
                            color: AppColors.primary,
                          
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextFormField(
                          focusNode: FocusNode(),
                          validator: validatePhone,
                          keyboardType: TextInputType.phone,
                          controller: con.model.insertPhoneController,
                          decoration: Constants.inputDecoration.copyWith(
                            labelText: "phone number",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(5.w),
                              child: TextView(
                                text:" +1 ",
                                    color: AppColors.primary, fontSize: 18.sp),
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Note: \n",
                            children: [
                              TextSpan(
                                text: "iPhone users can call ",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                              TextSpan(
                                text: 'customer care',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.textGreen10,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: '\nto register and book rides',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 8.w, right: 0, left: 0),
                          child: LoadingButton(
                            isLoading: con.model.isPhoneVerificationLoading,
                            label: (con.model.insertPhoneFormKey.currentState
                                        ?.validate() ==
                                    true)
                                ? "Verify Number"
                                : "Continue",
                            onPressed: con.phoneVerification,

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
