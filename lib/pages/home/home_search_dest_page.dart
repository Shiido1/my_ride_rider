import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/colors.dart';
import '../../controllers/home_controller.dart';
import '../../utils/router.dart';
import '../../widget/text_form_field.dart';

class HomeSearchDestination extends StatefulWidget {
  const HomeSearchDestination({Key? key}) : super(key: key);

  @override
  _HomeSearchDestinationState createState() => _HomeSearchDestinationState();
}

class _HomeSearchDestinationState extends StateMVC<HomeSearchDestination> {
  _HomeSearchDestinationState() : super(HomeController()) {
    con = controller as HomeController;
  }

  late HomeController con;
  String googleApikey = "AIzaSyAaF3Z1gioxA2z3_7kwD9nyDu1nhFcaT8U";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(9.072264, 7.491302);
  final databaseReference = FirebaseDatabase.instance.ref();

  TextEditingController destinationController =
      TextEditingController(text: 'Enter destination location');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
              height: 350,
              // width: Adaptive.w(100),
              decoration: const BoxDecoration(color: AppColors.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nearest ride is',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '7min away',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: AppColors.primary,
                        ),
                        radius: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "Your Pickup Location",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "$pickUpLocationAdd",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        "Change Location",
                        style: TextStyle(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 20.sp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              // height: Adaptive.h(100) - 250,
              color: AppColors.greyWhite,
              padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    EditTextForm(
                      onTapped: () async {
                        var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApikey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'ng')],
                          //google_map_webservice package
                          onError: (err) {
                            print(err);
                          },
                        );

                        if (place != null) {
                          setState(() {
                            dropLocationAdd = place.description;
                            destinationController =
                                TextEditingController(text: dropLocationAdd);
                          });
                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(
                            apiKey: googleApikey,
                            apiHeaders:
                                await const GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );
                          String placeid = place.placeId ?? "0";
                          final detail =
                              await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          dropLat = geometry.location.lat.toString();
                          dropLong = geometry.location.lng.toString();
                        }
                      },
                      readOnly: true,
                      controller: destinationController,
                      suffixWidget: InkWell(
                          onTap: () {
                            Routers.pushNamed(context, '/select_ride');
                          },
                          child: const Icon(Icons.search)),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'History',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    SizedBox(
                      height: 25.h,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return addedHistory();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          height: 40,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.black),
              bottom: BorderSide(width: 2.0, color: Colors.white),
            ),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.location_on_rounded,
                color: Colors.red,
              ),
              Text(
                "View on Map",
                style: TextStyle(color: Colors.black, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }

  addedHistory() => InkWell(
        onTap: () {},
        child: Card(
          color: Colors.blueGrey[100],
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Colors.white,
                  ),
                  radius: 15,
                ),
                const SizedBox(width: 20),
                Column(
                  children: const [Text("Bannex Plaza"), Text("Wuse zone 2")],
                )
              ],
            ),
          ),
        ),
      );
}
