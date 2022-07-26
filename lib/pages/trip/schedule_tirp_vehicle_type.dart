import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/provider.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../constants/session_manager.dart';
import '../../controllers/auth_controller.dart';
import '../../models/global_model.dart';
import '../../widget/TextWidget.dart';

class ScheduleTripVehicle extends StatefulWidget {
  const ScheduleTripVehicle({Key? key}) : super(key: key);

  @override
  State createState() => _ScheduleTripVehicleState();
}

class _ScheduleTripVehicleState extends StateMVC<ScheduleTripVehicle> {
  _ScheduleTripVehicleState() : super(AuthController()) {
    con = controller as AuthController;
  }

  late AuthController con;
  bool? isSelectedRide = false;

  TextEditingController? pickupController =
      TextEditingController(text: pickUpLocationAdd);
  TextEditingController destinationController =
      TextEditingController(text: dropLocationAdd);
  String? vehicleTypeId;

  createScheduleTrip() async {
    con.scheduleTrip(
        vehicleType: 'eb7d7a67-b710-450a-b1c8-d52a8d0db8eb',
        scheduleTripDate: '$scheduleDate $timeText',
        schedulePeriod: scheduleValue!.toLowerCase());
  }

  @override
  void initState() {
    Provider.of<GoogleApiProvider>(context, listen: false).getVehicleTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GoogleApiProvider>(context, listen: false).getVehicleTypes();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Routers.pop(context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: SessionManager
                                      .instance.usersData["profile_picture"] ==
                                  null ||
                              SessionManager
                                      .instance.usersData["profile_picture"] ==
                                  ''
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                color: AppColors.grey1,
                                size: 23.sp,
                              ),
                              radius: 26,
                            )
                          : CircleAvatar(
                              radius: 28,
                              child: CachedNetworkImage(
                                imageUrl: SessionManager
                                    .instance.usersData["profile_picture"],
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
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    'Order',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
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
                              child: const TextWidget(),
                              height: 10.5.h,
                              decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.w),
                              child: Container(
                                padding: EdgeInsets.only(top: 3.w),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 3,
                                    width: 20.h,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                                height: 9.h,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25))),
                              ),
                            ),
                          ],
                        ),
                        if (con.model.isScheduleLoading)
                          Center(
                            child: SpinKitWave(
                              color: AppColors.primary,
                              size: 25.sp,
                            ),
                          ),
                        if (!con.model.isScheduleLoading)
                          SizedBox(
                              height: 20.h,
                              child: Consumer<GoogleApiProvider>(
                                  builder: (_, provider, __) {
                                if (provider.responsesVeh == null) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ));
                                }
                                if (provider.responsesVeh!["data"].isEmpty) {
                                  return Center(
                                    child: TextView(
                                      text: '',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      provider.responsesVeh!["data"].length,
                                  itemBuilder: (context, index) {
                                    return vehecleTabFlow(
                                      id: provider.responsesVeh!["data"][index]
                                          ["id"],
                                      name: provider.responsesVeh!["data"]
                                              [index]["name"]
                                          .toString(),
                                    );
                                  },
                                );
                              })),
                        InkWell(
                          onTap: () => createScheduleTrip(),
                          child: Container(
                            width: 55.w,
                            height: 6.h,
                            decoration:
                                const BoxDecoration(color: AppColors.primary),
                            child: Center(
                              child: con.model.isInstantLoading
                                  ? SpinKitWave(
                                      color: Colors.white,
                                      size: 20.sp,
                                    )
                                  : TextView(
                                      text: 'Select',
                                      color: AppColors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        isSelectedRide! ||
                                isSelectedRide! ||
                                isSelectedRide! == true
                            ? TextView(
                                onTap: () => con.cancelTrip(context),
                                text: 'Cancel Request',
                                color: AppColors.red,
                                fontSize: 16.5.sp,
                                fontWeight: FontWeight.w700)
                            : Container(),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    )),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  vehecleTabFlow({String? id, String? name}) => InkWell(
        onTap: () {
          setState(() {
            vehicleTypeId = id!;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 3.w),
              width: 30.w,
              height: 10.h,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(
                  'assets/images/car.png',
                )),
                color: !isSelectedRide!
                    ? AppColors.transparent
                    : AppColors.greyWhite1,
              ),
            ),
            TextView(
                text: name ?? '', fontSize: 16.sp, fontWeight: FontWeight.w700),
          ],
        ),
      );
}
