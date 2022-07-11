import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../constants/session_manager.dart';
import '../../models/global_model.dart';
import '../../utils/router.dart';
import '../../widget/text_widget.dart';

class SelectedDriverScreen extends StatefulWidget {
  final String fname;
  final String lname;
  final String color;
  final String plateNo;
  final String carname;
  const SelectedDriverScreen({
    Key? key,
    required this.fname,
    required this.lname,
    required this.color,
    required this.plateNo,
    required this.carname,
  }) : super(key: key);

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
        child: Column(
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
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                'Order',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
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
                        padding: EdgeInsets.only(top: 7.w),
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
                              decoration: Constants.defaultDecoration.copyWith(
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
                              decoration: Constants.defaultDecoration.copyWith(
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
            SizedBox(
              height: 4.h,
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 1.5.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.5.w, vertical: 1.2.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.white, width: 2),
                              ),
                              child: Icon(
                                Icons.phone,
                                color: AppColors.white,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 1.5.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.8.w, vertical: 1.2.w),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                              ),
                              child: Icon(
                                Icons.message,
                                color: AppColors.primary,
                                size: 22.sp,
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 1.5.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 2.5.w),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                              ),
                              child: TextView(
                                  text: 'Driver accepted Ride',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 1.5.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.8.w, vertical: 1.3.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.white, width: 2),
                              ),
                              child: Icon(
                                Icons.location_on,
                                color: AppColors.white,
                                size: 20.sp,
                              ),
                            ),
                          ],
                        ),
                        height: 10.h,
                        decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 13.5.w),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 3.w, left: 7.w, right: 7.w),
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
                              height: 55,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(22),
                                      topLeft: Radius.circular(22))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.w, right: 6.w),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: TextView(
                                        text: 'Your Ride',
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 7.5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                              text:
                                                  '${widget.fname} ${widget.lname}',
                                              fontSize: 16.5.sp,
                                              fontWeight: FontWeight.w700),
                                          SizedBox(
                                            height: 2.w,
                                          ),
                                          Row(
                                            children: [
                                              TextView(
                                                  text: 'Total No of rides: ',
                                                  fontSize: 15.5.sp,
                                                  fontWeight: FontWeight.w500),
                                              SizedBox(
                                                width: 1.w,
                                              ),
                                              TextView(
                                                  text: '54',
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.w,
                                          ),
                                          TextView(
                                              text: '* * * * * *',
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w700),
                                          Padding(
                                            padding: EdgeInsets.only(left: 6.w),
                                            child: TextView(
                                                text: '4.0',
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                              text: widget.carname,
                                              fontSize: 16.5.sp,
                                              fontWeight: FontWeight.w700),
                                          SizedBox(
                                            height: 2.w,
                                          ),
                                          Row(
                                            children: [
                                              TextView(
                                                  text: 'Color: ',
                                                  fontSize: 15.5.sp,
                                                  fontWeight: FontWeight.w500),
                                              SizedBox(
                                                width: 1.w,
                                              ),
                                              TextView(
                                                  text: widget.color,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.w,
                                          ),
                                          Row(
                                            children: [
                                              TextView(
                                                  text: 'Plate No: ',
                                                  fontSize: 15.5.sp,
                                                  fontWeight: FontWeight.w500),
                                              SizedBox(
                                                width: 1.w,
                                              ),
                                              TextView(
                                                  text: widget.plateNo,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 3.w),
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                    ),
                                    child: TextView(
                                        onTap: () => Routers.pushNamed(
                                            context, '/card_payment'),
                                        text: 'Confirm',
                                        color: AppColors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  TextView(
                                      onTap: () =>
                                          Routers.pushNamed(context, '/home'),
                                      text: 'Cancel Request',
                                      color: AppColors.red,
                                      fontSize: 16.5.sp,
                                      fontWeight: FontWeight.w700),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
