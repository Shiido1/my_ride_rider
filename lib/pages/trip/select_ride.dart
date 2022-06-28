import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/utils/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/constants.dart';
import '../../controllers/auth_controller.dart';
import '../../models/driver.model.dart';
import '../../utils/driver_utils.dart';
import '../../widget/TextWidget.dart';

class SelectRide extends StatefulWidget {
  SelectRide({Key? key}) : super(key: key);

  @override
  State createState() => _SelectRideState();
}

class _SelectRideState extends StateMVC<SelectRide> {
  _SelectRideState() : super(AuthController()) {
    con = controller as AuthController;
  }

  late AuthController con;

  DatabaseReference snapshot1 = FirebaseDatabase.instance.ref('drivers');
  Stream<DatabaseEvent>? stream;
  LatLng? _pickUpLocation;
  final databaseReference = FirebaseDatabase.instance.ref();

  TextEditingController? pickupController =
      TextEditingController(text: pickUpLocationAdd);
  TextEditingController destinationController =
      TextEditingController(text: dropLocationAdd);

  getUsers() async {
    stream = snapshot1.onValue;
    stream!.listen((event) {});
  }


  @override
  void initState() {
    getUsers();
    _pickUpLocation =
        LatLng(double.parse(pickUpLat!), double.parse(pickUpLong!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUsers();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6.h),
                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: CircleAvatar(
                      foregroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: AppColors.primary,
                      ),
                      radius: 20,
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
                            child: const TextWidget(),
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
                      ),
                      if (con.model.isLoading)
                        Center(
                          child: SpinKitWave(
                            color: AppColors.primary,
                            size: 25.sp,
                          ),
                        ),
                      if (!con.model.isLoading)
                        Column(
                          children: [
                            StreamBuilder(
                                stream: snapshot1.onValue,
                                builder:
                                    (_, AsyncSnapshot<DatabaseEvent> snap) {
                                  if (snap.data == null || !snap.hasData) {
                                    return Container();
                                  }
                                  final d = Map<dynamic, dynamic>.from(snap
                                      .data!
                                      .snapshot
                                      .value! as Map<dynamic, dynamic>);

                                  AvailableDrivers data =
                                      AvailableDrivers.fromMap(map: d);

                                  final value1 = DriversUtil.returnClosest(
                                      _pickUpLocation!,
                                      data.driversInformations!
                                          .where((element) =>
                                              element.isActive == 1 &&
                                              element.isAvailable == 1 &&
                                              element.isApproved == 1 &&
                                              element.vehicleTypeName ==
                                                  "Regular")
                                          .toList());
                                  final value2 = DriversUtil.returnClosest(
                                      _pickUpLocation!,
                                      data.driversInformations!
                                          .where((element) =>
                                              element.isActive == 1 &&
                                              element.isAvailable == 1 &&
                                              element.isApproved == 1 &&
                                              element.vehicleTypeName ==
                                                  "Executive")
                                          .toList());
                                  final value3 = DriversUtil.returnClosest(
                                      _pickUpLocation!,
                                      data.driversInformations!
                                          .where((element) =>
                                              element.isActive == 1 &&
                                              element.isAvailable == 1 &&
                                              element.isApproved == 1 &&
                                              element.vehicleTypeName ==
                                                  "Coperate")
                                          .toList());

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () => updateStatus(
                                            id: value1.id.toString(),
                                            status: 'requested',
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(4.w),
                                            margin: EdgeInsets.all(8.w),
                                            decoration: const BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(20.0),
                                                  bottomRight:
                                                      Radius.circular(20.0),
                                                  topLeft:
                                                      Radius.circular(20.0),
                                                  bottomLeft:
                                                      Radius.circular(20.0)),
                                            ),
                                            child: Text(
                                              value1.name ?? '',
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: AppColors.greyWhite,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 70,
                            ),
                            InkWell(
                              onTap: () {
                                // requestRide(context);
                              },
                              child: Container(
                                width: 200,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: AppColors.primary),
                                child: const Center(
                                  child: Text(
                                    'Select',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  up({path, status}) async {
    await snapshot1.child(path).update(updatefb(status: status));
  }

  Map<String, dynamic> updatefb({String? status}) => {
        'status': status,
      };

  updateStatus({String? id, String? status, String? token}) async {
    String token = await getToken(id);
    con.sendPushNot(token: token);
    up(path: id, status: status);
    saveRequestToDataBase(id, status);
  }

  Future<String> getToken(id) async {
    DatabaseEvent ds =
        await databaseReference.child("drivers").child(id).once();
    Map<String, dynamic> res =
        Map<String, dynamic>.from(ds.snapshot.value as Map);

    return (res["token"]);
  }

  Future saveRequestToDataBase(String? id, String? status) async {
    databaseReference.child("UserRequest").set({
      'pick_address': pickUpLocationAdd,
      'pick_lat': pickUpLat,
      'pick_lng': pickUpLong,
      'drop_lng': dropLong,
      'drop_lat': dropLat,
      'drivers_id': id,
      'status': status,
      'drop_address': dropLocationAdd
    });
  }

  void requestRide(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Connecting to Ride...',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: Adaptive.sp(21)),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: SpinKitWave(
                    color: AppColors.primary,
                    size: 25.0,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Please wait....',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Routers.replaceAllWithName(context, "/home");
                  },
                  child: const Text(
                    'Cancel Request',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
            width: Adaptive.w(80),
            height: 400,
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 10), () {
      Routers.pop(context);
      Routers.pushNamed(context, "/order");
    });
  }
}
