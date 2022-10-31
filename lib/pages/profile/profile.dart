import 'package:flutter/material.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/partials/mixins/validations.dart';
import 'package:my_ride/schemas/user.dart';
import 'package:my_ride/states/auth_state.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../components/reg_model.dart';
import '../../controllers/auth_controller.dart';
import '../../models/global_model.dart';
import '../../utils/router.dart';
import '../../widget/image_picker.dart';
import '../../widget/text_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends StateMVC<ProfilePage> with ValidationMixin {
  _ProfilePageState() : super(AuthController()) {
    con = controller as AuthController;
  }
  late AuthController con;

  final _pickImage = ImagePickerHandler();

  @override
  void initState() {
    super.initState();
    User user = context.read<AuthProvider>().user;
    con.model.firstNameController.text = user.firstName ?? "";
    con.model.lastNameController.text = user.lastName ?? "";
    con.model.emailController.text = user.emailAdd ?? "";
    con.model.phoneNumberController.text = user.phoneNum ?? "";
    con.model.phoneVersionController.text = user.typeOfDevice ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Adaptive.w(5), vertical: 10),
          child: SizedBox(
            height: Adaptive.h(100) - 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 8.h),
                Form(
                  key: con.model.formKey,
                  child: Expanded(
                    child: ListView(
                      children: [
                        GestureDetector(
                          onTap: () => _getProfileImage(context),
                          child: Center(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    profileImage != null
                                        ? CircleAvatar(
                                            radius: 40,
                                            backgroundImage:
                                                FileImage(profileImage!),
                                            backgroundColor: Colors.transparent,
                                          )
                                        : Center(
                                            child: Image.asset(
                                              'assets/images/profileavater.png',
                                              width: 90,
                                              height: 90,
                                            ),
                                          ),
                                    const Positioned(
                                        left: 200,
                                        top: 17,
                                        child: Icon(Icons.camera_alt)),
                                  ],
                                ),
                                SizedBox(height: Adaptive.h(1)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    Icon(Icons.edit, size: 17.sp),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 9.h),
                        Column(
                          children: [
                            Row(
                              children: [
                                TextView(
                                  text: 'First Name:',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.5.sp,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                TextView(
                                  text: '$firstNam',
                                  fontSize: 16.sp,
                                )
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Column(
                          children: [
                            Row(
                              children: [
                                TextView(
                                  text: 'Last Name:',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.5.sp,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                TextView(
                                  text: '$lastNam',
                                  fontSize: 16.sp,
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Column(
                          children: [
                            Row(
                              children: [
                                TextView(
                                  text: 'Phone No:',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.5.sp,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                TextView(
                                  text: phoneNum!,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.5.sp,
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Column(
                          children: [
                            Row(
                              children: [
                                TextView(
                                  text: 'Email Address:',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.5.sp,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                TextView(
                                  text: email!,
                                  fontSize: 16.sp,
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Column(
                          children: [
                            Row(
                              children: [
                                TextView(
                                  text: 'Password:',
                                  fontSize: 16.5.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                TextView(
                                  text: '************',
                                  fontSize: 16.sp,
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40,
                              right: Adaptive.w(15),
                              left: Adaptive.w(15)),
                          child: ElevatedButton(
                            onPressed: () {
                              Routers.pushNamed(context, '/reg_success');
                              // setState(() {
                              //   isRegistration = true;
                              // });
                            },
                            child: TextView(
                              text: 'Continue',
                              fontSize: 16.sp,
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size.fromHeight(50)),
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.primary),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0))),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getProfileImage(BuildContext context) {
    try {
      _pickImage.pickImage(
          context: context,
          file: (file) {
            setState(() {
              profileImage = file;
              con.getUserProfileData(image: profileImage, context: context);
            });
          });
    } catch (e) {
      throw (e.toString());
    }
  }
}
