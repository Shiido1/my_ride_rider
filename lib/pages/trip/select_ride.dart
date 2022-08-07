import 'dart:async';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/models/provider.dart';
import 'package:my_ride/pages/trip/selected_driver_screen.dart';
import 'package:my_ride/utils/router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/constants.dart';
import '../../constants/session_manager.dart';
import '../../controllers/auth_controller.dart';
import '../../models/driver.model.dart';
import '../../utils/driver_utils.dart';
import '../../widget/TextWidget.dart';
import '../../widget/date/custom_dialog_for_rejection.dart';
import '../../widget/text_widget.dart';

class SelectRide extends StatefulWidget {
  const SelectRide({Key? key}) : super(key: key);

  @override
  State createState() => _SelectRideState();
}

class _SelectRideState extends StateMVC<SelectRide> {
  _SelectRideState() : super(AuthController()) {
    con = controller as AuthController;
  }

  late AuthController con;
  final _stream = databaseReference.child("drivers");
  Stream<DatabaseEvent>? stream;

  TextEditingController? pickupController =
      TextEditingController(text: pickUpLocationAdd);
  TextEditingController destinationController =
      TextEditingController(text: dropLocationAdd);
  bool? isSelectClassic;
  bool? isSelectExecutive;
  bool? isSelectCoperate;
  LatLng? _pickUpLocation;
  dynamic instantValue;
  int? timeInMin;

  Future<void> getTimeDurationInMin() async {
    try {
      timeInMin = await Provider.of<GoogleApiProvider>(context, listen: false)
          .getTimeCostFromGoogleApi();
      log('object int in time dur $timeInMin');
    } catch (e) {
      log('Debug: $e');
    }
  }

  getInstantTripData() async {
    if (isSelectClassic! || isSelectExecutive! || isSelectCoperate == true) {
      con.instantTrip({
        "driver_id": instantValue.id.toString(),
        "driver_lat": instantValue.location[0],
        "driver_lng": instantValue.location[1]
      });
    }
  }

  getUsers() async {
    stream = snapshot1.onValue;
    stream!.listen((event) {});
    await getTimeDurationInMin();
    Provider.of<GoogleApiProvider>(context, listen: false)
        .estimatedCost(timeInMin.toString(), context: context);
  }

  @override
  void initState() {
    isSelectClassic = false;
    isSelectExecutive = false;
    isSelectCoperate = false;
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
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 4.w,top: 5.w),
                        child: SessionManager.instance
                                        .usersData["profile_picture"] ==
                                    null ||
                                SessionManager.instance
                                        .usersData["profile_picture"] ==
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFormField(
                                    readOnly: true,
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
                                    readOnly: true,
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
                              height: 6.5.h,
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
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                                height: 4.h,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25))),
                              ),
                            ),
                          ],
                        ),
                        if (con.model.isInstantLoading)
                          Center(
                            child: SpinKitWave(
                              color: AppColors.primary,
                              size: 25.sp,
                            ),
                          ),
                        if (!con.model.isInstantLoading)
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
                                                    "Classic")
                                            .toList());
                                    Provider.of<GoogleApiProvider>(context,
                                            listen: false)
                                        .getTimeFromGoogleApi(
                                            origin: pickUpLocationAdd,
                                            destination: value1.address);

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
                                    Provider.of<GoogleApiProvider>(context,
                                            listen: false)
                                        .getTimeFromGoogleApiExe(
                                            origin: pickUpLocationAdd,
                                            destination: value2.address);

                                    final value3 = DriversUtil.returnClosest(
                                        _pickUpLocation!,
                                        data.driversInformations!
                                            .where((element) =>
                                                element.isActive == 1 &&
                                                element.isAvailable == 1 &&
                                                element.isApproved == 1 &&
                                                element.vehicleTypeName ==
                                                    "Corporate")
                                            .toList());

                                    Provider.of<GoogleApiProvider>(context,
                                            listen: false)
                                        .getTimeFromGoogleApiCoperate(
                                            origin: pickUpLocationAdd,
                                            destination: value3.address);
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () => setState(() {
                                              instantValue = value1;
                                              id = value1.id.toString();
                                              request = 'request';
                                              isSelectClassic = true;
                                              isSelectExecutive = false;
                                              isSelectCoperate = false;
                                              costOfRide = Provider.of<
                                                          GoogleApiProvider>(
                                                      context,
                                                      listen: false)
                                                  .classicEsCost?.toStringAsFixed(2)
                                                  .toString();
                                            }),
                                            child: Consumer<GoogleApiProvider>(
                                              builder: (_, model, __) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 3.w),
                                                    width: 30.w,
                                                    height: 10.h,
                                                    decoration: BoxDecoration(
                                                      image:
                                                          const DecorationImage(
                                                              image: AssetImage(
                                                        'assets/images/car.png',
                                                      )),
                                                      color: !isSelectClassic!
                                                          ? AppColors
                                                              .transparent
                                                          : AppColors
                                                              .greyWhite1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'CLASSIC',
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  TextView(
                                                      text: model.timeResponse ==
                                                              null
                                                          ? 'No vehicle\n available'
                                                          : '${model.timeResponse}\naway',
                                                      fontSize: 14.5.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textAlign:
                                                          TextAlign.center),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  TextView(
                                                    text: model.classicEsCost ==
                                                            null
                                                        ? 'No cost'
                                                        : '\$${model.classicEsCost?.toStringAsFixed(2)}',
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => setState(() {
                                              instantValue = value2;
                                              id = value2.id.toString();
                                              request = 'request';
                                              isSelectExecutive = true;
                                              isSelectClassic = false;
                                              isSelectCoperate = false;
                                              costOfRide = Provider.of<
                                                          GoogleApiProvider>(
                                                      context,
                                                      listen: false)
                                                  .executiveEsCost?.toStringAsFixed(2)
                                                  .toString();
                                            }),
                                            child: Consumer<GoogleApiProvider>(
                                              builder: (_, model, __) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 3.w),
                                                    width: 30.w,
                                                    height: 10.h,
                                                    decoration: BoxDecoration(
                                                      image:
                                                          const DecorationImage(
                                                              image: AssetImage(
                                                        'assets/images/car.png',
                                                      )),
                                                      color: !isSelectExecutive!
                                                          ? AppColors
                                                              .transparent
                                                          : AppColors
                                                              .greyWhite1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'EXECUTIVE',
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  TextView(
                                                      text: model.timeResponseExecutive ==
                                                              null
                                                          ? 'No vehicle\n available'
                                                          : "${model.timeResponseExecutive}\naway",
                                                      fontSize: 14.5.sp,
                                                      textAlign:
                                                          TextAlign.center,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  TextView(
                                                    text: model.coperateEsCost ==
                                                            null
                                                        ? 'No cost'
                                                        : '\$${model.executiveEsCost?.toStringAsFixed(2)}',
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => setState(() {
                                              instantValue = value3;
                                              id = value3.id.toString();
                                              request = 'request';
                                              isSelectCoperate = true;
                                              isSelectClassic = false;
                                              isSelectExecutive = false;
                                              costOfRide = Provider.of<
                                                          GoogleApiProvider>(
                                                      context,
                                                      listen: false)
                                                  .coperateEsCost?.toStringAsFixed(2)
                                                  .toString();
                                            }),
                                            child: Consumer<GoogleApiProvider>(
                                              builder: (_, model, __) => Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 3.w),
                                                    width: 30.w,
                                                    height: 10.h,
                                                    decoration: BoxDecoration(
                                                      image:
                                                          const DecorationImage(
                                                              image: AssetImage(
                                                        'assets/images/car.png',
                                                      )),
                                                      color: !isSelectCoperate!
                                                          ? AppColors
                                                              .transparent
                                                          : AppColors
                                                              .greyWhite1,
                                                    ),
                                                  ),
                                                  Text(
                                                    'COPERATE',
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  TextView(
                                                    text: model.timeResponseCoperate ==
                                                            null
                                                        ? 'No vehicle\n available'
                                                        : '${model.timeResponseCoperate}\naway',
                                                    fontSize: 14.5.sp,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  TextView(
                                                    text: model.coperateEsCost ==
                                                            null
                                                        ? 'No cost'
                                                        : '\$${model.coperateEsCost?.toStringAsFixed(2)}',
                                                    fontSize: 16.sp,
                                                    textAlign: TextAlign.start,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: 7.8.h,
                              ),
                              InkWell(
                                onTap: () async {
                                  updateStatus(
                                    id: id,
                                    status: request,
                                  );
                                  token = await getToken(id);
                                },
                                child: Container(
                                  width: 200,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: AppColors.primary),
                                  child: Center(
                                    child: con.model.isInstantLoading
                                        ? SpinKitWave(
                                            color: Colors.white,
                                            size: 20.sp,
                                          )
                                        : TextView(
                                            text: isSelectClassic! ||
                                                    isSelectExecutive! ||
                                                    isSelectCoperate! == true
                                                ? 'Request ride'
                                                : 'Select',
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
                              isSelectClassic! ||
                                      isSelectExecutive! ||
                                      isSelectCoperate! == true
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
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateStatus({
    String? id,
    String? status,
  }) async {
    await getInstantTripData();
    up(path: id, status: status);
    saveRequestToDataBase(id, status);
    listenToRequestEvent(context);
  }

  Future<String> getToken(id) async {
    DatabaseEvent ds =
        await databaseReference.child("drivers").child(id).once();
    Map<String, dynamic> res =
        Map<String, dynamic>.from(ds.snapshot.value as Map);

    return (res["token"]);
  }

  Future saveRequestToDataBase(String? id, String? status) async {
    databaseReference
        .child("users_request")
        .child('${SessionManager.instance.usersData["id"]}')
        .set({
      'pick_address': pickUpLocationAdd,
      'pick_lat': pickUpLat,
      'pick_lng': pickUpLong,
      'drop_lng': dropLong,
      'drop_lat': dropLat,
      'drivers_id': id,
      'status': status,
      'drop_address': dropLocationAdd,
      'mobile': SessionManager.instance.usersData["mobile"],
      'arrive_pick_up': 'not yet',
      'arrive_drop': 'not yet',
    });
  }

  listenToRequestEvent(context) async {
    Map<String, dynamic>? driverRes;
    StreamSubscription<DatabaseEvent>? _counterSubscription;
    DatabaseEvent dataEvent =
        await databaseReference.child("drivers").child(id!).once();
    driverRes = Map<String, dynamic>.from(dataEvent.snapshot.value as Map);

    _counterSubscription = _stream.child(id!).onChildChanged.listen((event) {
      if (event.snapshot.value.toString() == 'Accepted') {
        driverFname = driverRes?['name'];
        vehicleNumber = driverRes?['vehicle_number'];
        vehicleColor = driverRes?['vehicle_color'];
        vehicleName = driverRes?['vehicle_make'];
        mobile = driverRes?['mobile'].toString();
        noOfRides = driverRes?['no_of_rides'].toString();
        Routers.replace(
            context,
            SelectedDriverScreen(
                fName: driverFname ?? '',
                color: vehicleColor ?? '',
                plateNo: vehicleNumber ?? '',
                noOfRides: noOfRides ?? '',
                carName: vehicleName ?? ''));
        _counterSubscription?.cancel();
      } else if (event.snapshot.value.toString() == 'Ignore') {
        Routers.replaceAllWithName(context, '/home');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialogForRejection();
            });
        _counterSubscription?.cancel();
      }
    });
  }
}
