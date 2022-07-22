import 'package:flutter/material.dart';
import 'package:my_ride/components/my_app_bar.dart';
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
        // appBar: MyAppBar.defaultAppBar(context),
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
                const SizedBox(height: 20),
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
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'First Name:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text('$firstNam')
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Last Name:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text('$lastNam')
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Phone No:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text('${phoneNum}')
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Email Address:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text('${email}')
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Password:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('***********')
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40,
                              right: Adaptive.w(15),
                              left: Adaptive.w(15)),
                          child: ElevatedButton(
                            onPressed: () {
                              Routers.pushNamed(context, '/add_card');
                              setState(() {
                                isRegistration = true;
                              });
                            },
                            child: const Text("Continue"),
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
                        const SizedBox(height: 40),
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
    } catch (e) {}
  }
}
