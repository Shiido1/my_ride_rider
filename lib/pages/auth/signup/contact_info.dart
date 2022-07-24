import 'package:flutter/material.dart';
import 'package:my_ride/components/loading_button.dart';
import 'package:my_ride/components/my_app_bar.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/constants/constants.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:my_ride/partials/mixins/validations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../widget/text_widget.dart';

class ContactInfoPage extends StatefulWidget {
  const ContactInfoPage({Key? key}) : super(key: key);

  @override
  State createState() => _ContactInfoPageState();
}

class _ContactInfoPageState extends StateMVC<ContactInfoPage>
    with ValidationMixin {
  _ContactInfoPageState() : super(AuthController()) {
    con = controller as AuthController;
  }
  late AuthController con;

  @override
  void initState() {
    super.initState();
    con.model.regPhoneNumberController.text =
        con.model.insertPhoneController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.defaultAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5), vertical: 10),
        child: SizedBox(
          height: Adaptive.h(100) - 100,
          child: Form(
            key: con.model.regFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: 'Contact Information',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                SizedBox(height: 4.h),
                Expanded(
                  child: ListView(
                    children: [
                      TextFormField(
                        validator: validateFirstName,
                        controller: con.model.regFirstNameController,
                        decoration: Constants.defaultDecoration.copyWith(
                          labelText: "First Name",
                        ),
                      ),
                      TextFormField(
                        validator: validateLastName,
                        controller: con.model.regLastNameController,
                        decoration: Constants.defaultDecoration.copyWith(
                          labelText: "Last Name",
                        ),
                      ),
                      TextFormField(
                        validator: validatePhone,
                        controller: con.model.regPhoneNumberController,
                        decoration: Constants.defaultDecoration.copyWith(
                          labelText: "Phone Number",
                        ),
                      ),
                      TextFormField(
                        validator: validateEmail,
                        controller: con.model.regEmailController,
                        decoration: Constants.defaultDecoration.copyWith(
                          labelText: "Email Address",
                        ),
                      ),
                      TextFormField(
                        validator: validatePassword,
                        obscureText: true,
                        controller: con.model.regPasswordController,
                        decoration: Constants.defaultDecoration.copyWith(
                          labelText: "Password",
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: con.model.regConfirmPassController,
                        decoration: Constants.defaultDecoration.copyWith(
                          labelText: "confirm pass",
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primary,
                            ),
                            text:
                                "By clicking on the register button, you have agreed to the ",
                            children: [
                              TextSpan(
                                text: "terms & condition",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                              TextSpan(
                                text: 'privacy policy',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              TextSpan(
                                text: '.',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.w,
                            right: Adaptive.w(15),
                            left: Adaptive.w(15)),
                        child: LoadingButton(
                          isLoading: con.model.isSignUpLoading,
                          label: "Register",
                          onPressed: con.signUp,
                          disabled:
                              con.model.regFormKey.currentState?.validate(),
                        ),
                      ),
                      SizedBox(height: 14.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
