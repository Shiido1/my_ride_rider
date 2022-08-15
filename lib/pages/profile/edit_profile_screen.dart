import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/loading_button.dart';
import '../../constants/colors.dart';
import '../../partials/mixins/validations.dart';
import '../../widget/text_form_field.dart';
import '../../widget/text_widget.dart';

class EditProfileScreen2 extends StatefulWidget {
  const EditProfileScreen2({Key? key}) : super(key: key);

  @override
  State createState() => _EditProfileScreen2State();
}

class _EditProfileScreen2State extends StateMVC<EditProfileScreen2>
    with ValidationMixin {
  _EditProfileScreen2State() : super(AuthController()) {
    con = controller as AuthController;
  }

  late AuthController con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
          child: Form(
            key: con.model.updateFormKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  TextView(
                    text: "Edit Profile",
                    color: AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  EditTextForm(
                    validator: validateEmail,
                    controller: con.model.emailController,
                    isMuchDec: true,
                    readOnly: false,
                    obscureText: false,
                    label: 'Email',
                  ),
                  SizedBox(height: 2.5.h),
                  EditTextForm(
                    validator: validateFirstName,
                    controller: con.model.firstNameController,
                    isMuchDec: true,
                    readOnly: false,
                    obscureText: false,
                    label: 'First name',
                  ),
                  SizedBox(height: 2.5.h),
                  EditTextForm(
                    validator: validateLastName,
                    controller: con.model.lastNameController,
                    isMuchDec: true,
                    readOnly: false,
                    obscureText: false,
                    label: 'Last name',
                  ),
                  SizedBox(height: 2.5.h),
                  EditTextForm(
                    validator: validatePhone,
                    controller: con.model.phoneNumberController,
                    isMuchDec: true,
                    readOnly: false,
                    obscureText: false,
                    label: 'Mobile',
                  ),
                  SizedBox(height: 5.h),
                  LoadingButton(
                    label: "Send",
                    onPressed: con.updateProfile,
                    disabled: false,
                    isLoading: con.model.isUpdatingLoading,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
