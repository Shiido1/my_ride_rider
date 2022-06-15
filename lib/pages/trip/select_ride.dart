import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/controllers/trip_controller.dart';
import 'package:my_ride/states/trip_state.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/widget/carWidget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/constants.dart';
import '../../widget/TextWidget.dart';

class SelectRide extends StatefulWidget {
  SelectRide({Key? key}) : super(key: key);

  @override
  State createState() => _SelectRideState();
}

class _SelectRideState extends StateMVC<SelectRide> {
  _SelectRideState() : super(TripController()) {
    con = controller as TripController;
  }

  late TripController con;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    con.getAvailableRides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                              SizedBox(height: 20),
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
             /* Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 50,
                child: SizedBox(
                  // height: 200,
                  child: GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ),*/
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
                            child: TextWidget(),
                            height: 100,
                            decoration: BoxDecoration(
                                color: Color(0XFF000B49),
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
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      if (con.model.isLoading)
                        Center(
                          child: SpinKitWave(
                            color: AppColors.primary,
                            size: 25.0,
                          ),
                        ),
                      if (!con.model.isLoading)
                        Column(
                          children: [
                            Consumer<TripProvider>(
                                builder: (BuildContext context, value, _child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: getAvailableCarWidget(
                                    value.availableVehicles),
                              );
                            }),
                            SizedBox(
                              height: 70,
                            ),
                            InkWell(
                              onTap: () {
                                requestRide(context);
                              },
                              child: Container(
                                width: 200,
                                height: 40,
                                decoration:
                                    BoxDecoration(color: Color(0XFF000B49)),
                                child: const Center(
                                  child: Text(
                                    'Select',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: () {
                                print("createRequestMap method clicked");
                                createRequestMap();
                              },
                              child: Container(
                                width: 200,
                                height: 40,
                                decoration:
                                BoxDecoration(color: Color(0XFF000B49)),
                                child: const Center(
                                  child: Text(
                                    'Request Ride',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
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
    );
  }

  void requestRide(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Connecting to Ride...',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: Adaptive.sp(21)),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: SpinKitWave(
                    color: AppColors.primary,
                    size: 25.0,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Please wait....',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Routers.replaceAllWithName(context, "/home");
                  },
                  child: Text(
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

  getAvailableCarWidget(Map<String, dynamic> availableCars) {
    List<Widget> _temp = [];

    availableCars.forEach((key, value) {
      _temp.add(InkWell(
          onTap: (con.model.selectedCar.tripSessionId == value.tripSessionId)
              ? () {}
              : () {
                  setState(() {
                    con.model.selectedCar = value;
                  });
                },
          child: CarWidget(
            isSelected:
                (con.model.selectedCar.tripSessionId == value.tripSessionId),
            time: value.arrivalTime,
            carType: key,
            money: '\$' + value.tripFare,
            imageUrl: value.vehicleImg,
          )));
    });
    return _temp;
  }

  Future <void> createRequestMap() async {
    CollectionReference userResquestRef = await FirebaseFirestore.instance.collection("UserRequest");
    print("user map: $userResquestRef");
  }
}
