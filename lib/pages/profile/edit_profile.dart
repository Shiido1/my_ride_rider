import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_ride/constants/session_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/my_app_bar.dart';
import '../../components/reg_model.dart';
import '../../constants/colors.dart';
import '../../controllers/auth_controller.dart';
import '../../partials/mixins/validations.dart';
import '../../widget/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends StateMVC<EditProfileScreen>
    with ValidationMixin {
  _EditProfileScreenState() : super(AuthController()) {
    con = controller as AuthController;
  }

  late AuthController con;

  final _pickImage = ImagePickerHandler();

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.defaultAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5), vertical: 10),
        child: SizedBox(
          height: Adaptive.h(100) - 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Review Your Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: con.model.formKeyEdit,
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
                                  SessionManager
                                              .instance.usersData.isNotEmpty ||
                                          SessionManager.instance.usersData[
                                                  'profile_picture'] !=
                                              null
                                      ? CircleAvatar(
                                          radius: 40,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "https://myride.dreamlabs.com.ng/storage/uploads/user/profile-picture/${SessionManager.instance.usersData["profile_picture"]}",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget: (context, url,
                                                    error) =>
                                                const CircularProgressIndicator(),
                                          ),
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
                              Text(
                                  '${SessionManager.instance.usersData["name"]}')
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
                              Text(
                                  '${SessionManager.instance.usersData["last_name"]}')
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
                              Text(
                                  '${SessionManager.instance.usersData["mobile"]}')
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
                              Text(
                                  '${SessionManager.instance.usersData["email"]}')
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
                    ],
                  ),
                ),
              )
            ],
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
