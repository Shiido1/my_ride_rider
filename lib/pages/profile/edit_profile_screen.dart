import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/loading_button.dart';
import '../../components/my_app_bar.dart';
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
      appBar: MyAppBar.defaultAppBar(context),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
          child: Form(
            key: con.model.updateFormKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  TextView(
                    text: "Edit Profile",
                    color: AppColors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  EditTextForm(
                    validator: validateFirstName,
                    controller: con.model.firstNameController,
                    isMuchDec: true,
                    readOnly: false,
                    obscureText: false,
                    label: 'First name',
                  ),
                  SizedBox(height: 3.h),
                  EditTextForm(
                    validator: validateLastName,
                    controller: con.model.lastNameController,
                    isMuchDec: true,
                    readOnly: false,
                    obscureText: false,
                    label: 'Last name',
                  ),
                  SizedBox(height: 20.h),
                  LoadingButton(
                    label: "Update",
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
