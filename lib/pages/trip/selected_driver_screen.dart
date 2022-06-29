import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../constants/session_manager.dart';
import '../../models/global_model.dart';

class SelectedDriverScreen extends StatefulWidget {
  const SelectedDriverScreen({Key? key}) : super(key: key);

  @override
  State<SelectedDriverScreen> createState() => _SelectedDriverScreenState();
}

class _SelectedDriverScreenState extends State<SelectedDriverScreen> {

  TextEditingController? pickupController =
      TextEditingController(text: pickUpLocationAdd);
  TextEditingController destinationController =
      TextEditingController(text: dropLocationAdd);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.h),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: CircleAvatar(
                      radius: 28,
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://myride.dreamlabs.com.ng/storage/uploads/user/profile-picture/${SessionManager.instance.usersData["profile_picture"]}",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    'Order',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 250,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        height: 180,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: AppColors.primary,
                                ),
                                Container(
                                  height: 60,
                                  width: 1,
                                  decoration: const BoxDecoration(
                                    border: Border.symmetric(
                                      vertical: BorderSide(
                                        color: AppColors.primary,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.primary,
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 1.h),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  controller: pickupController,
                                  decoration:
                                      Constants.defaultDecoration.copyWith(
                                    labelText: "FROM",
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: destinationController,
                                  decoration:
                                      Constants.defaultDecoration.copyWith(
                                    labelText: "TO",
                                    labelStyle: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 1.w),
                          const Center(child: Icon(Icons.repeat))
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: Row(children: [
                              Container(decoration:BoxDecoration(border: Border())
                          )],),
                            height: 10.5.h,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.w),
                            child: Container(
                              padding: EdgeInsets.only(top: 3.w),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 3,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              height: 60,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30))),
                            ),
                          ),
                        ],
                      ),],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  
  }
}