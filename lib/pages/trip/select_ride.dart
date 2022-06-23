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

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  DatabaseReference snapshot1 = FirebaseDatabase.instance.ref('drivers');
  Stream<DatabaseEvent>? stream;
  LatLng? _pickUpLocation, _dropLocation;
  final databaseReference = FirebaseDatabase.instance.ref();

  getUsers() async {
    stream = snapshot1.onValue;
    stream!.listen((event) {});
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUsers();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 250,
                  width: 300,
                  padding: const EdgeInsets.all(30),
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
                                  height: 50,
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
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: con.model.pickupController,
                                  decoration:
                                      Constants.defaultDecoration.copyWith(
                                    labelText: "FROM",
                                  ),
                                  onTap: () {
                                    setState(() {
                                      // con.model.focusInput = "pickup";
                                    });
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: con.model.destinationController,
                                  decoration:
                                      Constants.defaultDecoration.copyWith(
                                    labelText: "TO",
                                  ),
                                  onTap: () {
                                    setState(() {
                                      //  con.model.focusInput = "destination";
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Center(child: Icon(Icons.repeat))
                        ]),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              child: const TextWidget(),
                              height: 100,
                              decoration: BoxDecoration(
                                  color: const Color(0XFF000B49),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 3,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                    )
                                  ],
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
                        const SizedBox(
                          height: 80,
                        ),
                        if (con.model.isLoading)
                          const Center(
                            child: const SpinKitWave(
                              color: AppColors.primary,
                              size: 25.0,
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

                                    final value = DriversUtil.returnClosest(
                                        _pickUpLocation,
                                        data.driversInformations!);

                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...value
                                              .map((driver) => InkWell(
                                                    onTap: () => updateStatus(
                                                      id: driver.id.toString(),
                                                      status: 'requested',
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8.w),
                                                      margin:
                                                          EdgeInsets.all(8.w),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 123, 107, 215),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        40.0),
                                                                bottomRight:
                                                                    Radius.circular(
                                                                        40.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        40.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        40.0)),
                                                      ),
                                                      child: Text(
                                                        driver.name ?? '',
                                                        style: TextStyle(
                                                            fontSize: 20.sp,
                                                            color: AppColors
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ))
                                              .toList()
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
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: const Color(0XFF000B49)),
                                  child: const Center(
                                    child: Text(
                                      'Select',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                      ],
                    ),
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
