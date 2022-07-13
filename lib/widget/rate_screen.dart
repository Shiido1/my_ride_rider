import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/widget/text_form_field.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/colors.dart';
import '../constants/session_manager.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key}) : super(key: key);

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 7.5.h,
                ),
                CircleAvatar(
                  radius: 70,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://myride.dreamlabs.com.ng/storage/uploads/user/profile-picture/${SessionManager.instance.usersData["profile_picture"]}??'' ",
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
                SizedBox(
                  height: 4.h,
                ),
                TextView(
                  text: '${SessionManager.instance.usersData["name"]}',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5.h,
                ),
                TextView(
                  text: 'Help us improve your driving experience better',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextView(
                  text: 'RATE THE RIDER',
                  fontSize: 17.5.sp,
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.center,
                  color: AppColors.textGreen10,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Center(
                  child: RatingBar.builder(
                    initialRating: rate,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: AppColors.black,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                const EditTextForm(
                  label: 'Leave comment...',
                  readOnly: false,
                  obscureText: false,
                  isMuchDec: true,
                ),
                SizedBox(
                  height: 5.h,
                ),
                InkWell(
                  onTap: () => Routers.replaceAllWithName(context, '/home'),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                    ),
                    child: TextView(
                        text: 'Submit',
                        fontSize: 18.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
