import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/widget/map_screen.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/session_manager.dart';

class CardPayment extends StatelessWidget {
  const CardPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              color: AppColors.primary,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5.w,
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 28,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://myride.dreamlabs.com.ng/storage/uploads/user/profile-picture/${SessionManager.instance.usersData["profile_picture"]}",
                                  imageBuilder: (context, imageProvider) =>
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
                                  errorWidget: (context, url, error) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.w),
                          TextView(
                              text: 'Card',
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                          SizedBox(height: 10.w),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100.h - 210,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        TextView(
                            text: 'Amount:',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.5.sp),
                        SizedBox(
                          height: 3.h,
                        ),
                        TextView(
                            text: '\$2',
                            fontWeight: FontWeight.bold,
                            fontSize: 23.sp),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black26),
                          borderRadius: BorderRadius.all(Radius.circular(3.w))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 6.w, top: 3.w),
                        child: TextView(text: 'Card 4567', fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Card',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.sp),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Accepted Cards',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                              color: Colors.black38),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 34.w,
                            height: 5.5.h,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage(
                                        'assets/images/Mastercard.png')),
                                border:
                                    Border.all(width: 1, color: Colors.black26),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.w))),
                            child: const SizedBox(),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Container(
                            width: 34.w,
                            height: 5.5.h,
                            padding: EdgeInsets.all(1.5.w),
                            child: Image.asset(
                              'assets/images/visa.png',
                              height: 20,
                              fit: BoxFit.fitHeight,
                            ),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black26),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.w))),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Container(
                            width: 34.w,
                            height: 5.5.h,
                            padding: EdgeInsets.all(1.5.w),
                            child: Image.asset(
                              'assets/images/visa.png',
                              height: 20,
                              fit: BoxFit.fitHeight,
                            ),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black26),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.w))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Card No',
                        labelStyle: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Expiry Date',
                        labelStyle: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 70.w),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Cvv',
                          labelStyle: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.black,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () =>Routers.replace(context, MapScreen(fname: driverFname!, lname: driverLname!, pickLocation: pickUpLocationAdd!, dropLocation: dropLocationAdd!)),
                        child: Container(
                          width: 220,
                          height: 50,
                          decoration:
                              const BoxDecoration(color: Color(0XFF000B49)),
                          child: Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
