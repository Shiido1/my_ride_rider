import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:my_ride/widget/text_form_field.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/colors.dart';
import '../constants/session_manager.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key}) : super(key: key);

  @override
  State createState() => _RateScreenState();
}

class _RateScreenState extends StateMVC<RateScreen> {
  _RateScreenState() : super(AuthController()) {
    con = controller as AuthController;
  }

  late AuthController con;

  TextEditingController? commmentController = TextEditingController();
  double? rate;

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
                SessionManager.instance.usersData["profile_picture"] == null ||
                        SessionManager.instance.usersData["profile_picture"] ==
                            ''
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: AppColors.grey1,
                          size: 50.sp,
                        ),
                        radius: 70,
                      )
                    : CircleAvatar(
                        radius: 70,
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
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: AppColors.black,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        rate = rating;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                EditTextForm(
                  label: 'Leave comment...',
                  readOnly: false,
                  obscureText: false,
                  isMuchDec: true,
                  controller: commmentController,
                ),
                SizedBox(
                  height: 5.h,
                ),
                InkWell(
                  onTap: () {
                    con.ratings(context,
                        rate: rate.toString(),
                        comment: commmentController!.text);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                    ),
                    child: con.model.isRatingLoading
                        ? SpinKitWave(
                            color: Colors.white,
                            size: 20.sp,
                          )
                        : TextView(
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
