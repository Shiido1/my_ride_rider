import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/constants/constants.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:my_ride/controllers/home_controller.dart';
import 'package:my_ride/partials/mixins/validations.dart';
import 'package:my_ride/utils/local_storage.dart';
import 'package:my_ride/utils/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> with ValidationMixin {

  _HomePageState() : super(HomeController()) {
    con = controller as HomeController;
  }

  late HomeController con;
  int _selectedIndex = 0;

  List<String> items = [
    "Ocean center, Gudu",
    "Gudu Market, Gudu",
    "Ocean center, Gudu",
    "Ocean center, Gudu",
    "Ocean center, Gudu",
    "Ocean center, Gudu",
  ];
  final databaseReference = FirebaseDatabase.instance.ref();

  String googleApikey = "AIzaSyCV-cMBmwbrbTZSklLMnmq4aU3lTIHUJiE";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(9.072264, 7.491302);
  String pickLocationText = "Enter Pickup location";

  double? lat;
  double? long;
  @override
  Widget build(BuildContext context) {
    var userName = LocalStorage().fetch("usrFirstName");
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        child: drawerWidget(),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            height: 147,
            width: Adaptive.w(100),
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
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '7min away',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: con.openDrawer,
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: AppColors.primary,
                        ),
                        radius: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hi there",
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Select your pickup location',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Adaptive.h(100) - 250,
            padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        var place = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: googleApikey,
                            mode: Mode.overlay,
                            types: [],
                            strictbounds: false,
                            components: [Component(Component.country, 'np')],
                            //google_map_webservice package
                            onError: (err) {
                              print(err);
                            },
                        );

                        if(place != null){
                          setState(() {
                            pickLocationText = place.description.toString();

                          });
                          var newlocationValue = pickLocationText;
                          print("newLocationValue: $newlocationValue");
                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(apiKey:googleApikey,
                            apiHeaders: await GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );
                          String placeid = place.placeId ?? "0";
                          final detail = await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                           lat = geometry.location.lat;
                           long = geometry.location.lng;
                          var newlatlang = LatLng(lat!, long!);

                          //move map camera to selected place with animation
                          mapController?.animateCamera(CameraUpdate
                              .newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                        }
                      },

                      child: Container(
                        height: 40,
                        width: 225,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(pickLocationText,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),

                    ),

                    InkWell(
                        onTap: () {
                          saveRequestToDataBase();
                          Routers.pushNamed(context, '/home_search_dest');
                        },
                        child: Container(
                          child: Icon(Icons.search),
                        ))
                  ],
                ),

                Container(
                  height: 50,
                  width: Adaptive.w(80),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        color: AppColors.primary,
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 50,
                        width: Adaptive.w(75) - 50,
                        color: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your current location',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Peach tree center',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Add place',
                          style: TextStyle(
                            fontSize: 18.sp,
                            // fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const Icon(
                          Icons.add,
                          color: Colors.green,
                        )
                      ],
                    )
                  ],
                ),

                Text(
                  'Nearest Pickup Location',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(50) - 130,
                  child: ListView(
                    children: [
                      InkWell(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: Card(
                          color: Colors.blueGrey[100],
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
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
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    const Text("Bannex Plaza"),
                                    Text("Wuse zone 2")
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: Card(
                          color: Colors.blueGrey[100],
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
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
                                SizedBox(width: 20),
                                Column(
                                  children: const [
                                    Text("Bannex Plaza"),
                                    Text("Wuse zone 2")
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: Card(
                          color: Colors.blueGrey[100],
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
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
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    const Text("Bannex Plaza"),
                                    Text("Wuse zone 2")
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.blueGrey[100],
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
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
                              SizedBox(width: 20),
                              Column(
                                children: [
                                  const Text("Bannex Plaza"),
                                  Text("Wuse zone 2")
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: Card(
                          color: Colors.blueGrey[100],
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
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
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    const Text("Bannex Plaza"),
                                    Text("Wuse zone 2")
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: Card(
                          color: Colors.blueGrey[100],
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
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
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    const Text("Bannex Plaza"),
                                    Text("Wuse zone 2")
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: Card(
                          color: Colors.blueGrey[100],
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
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
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    const Text("Bannex Plaza"),
                                    Text("Wuse zone 2")
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: Card(
                          color: Colors.blueGrey[100],
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
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
                                SizedBox(width: 20),
                                Column(
                                  children: [
                                    const Text("Bannex Plaza"),
                                    Text("Wuse zone 2")
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    shrinkWrap: true,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {

                    Routers.pushNamed(context, "/schedule_page");

                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          'Book ride',
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.black),
                    bottom: BorderSide(width: 2.0, color: Colors.white),
                  ),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () {
                    print("this line");
                    Routers.pushNamed(context, '/google_map_page');
                  },
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
            ),
          )

        ],

      ),

    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      )),
      builder: (context) {
        return Container(
          height: Adaptive.h(100) - 50,
          width: double.infinity,
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
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
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
                          decoration: Constants.defaultDecoration.copyWith(
                            labelText: "FROM",
                          ),
                          onTap: () {
                            setState(() {
                              con.model.focusInput = "pickup";
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: con.model.destinationController,
                          decoration: Constants.defaultDecoration.copyWith(
                            labelText: "TO",
                          ),
                          onTap: () {
                            setState(() {
                              con.model.focusInput = "destination";
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
        );
      },
    );
  }

  Widget drawerWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Name',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              con.closeDrawer();
                              Routers.pushNamed(context, "/profile");
                            },
                            child: Text(
                              'Edit profile',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow[800],
                              ),
                              Text(
                                '4.0',
                                style: TextStyle(
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: con.closeDrawer, icon: Icon(Icons.close))
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.payment,
                size: 25.sp,
                color: AppColors.primary,
              ),
              title: Text(
                "Payment",
                style: TextStyle(fontSize: 17.sp),
              ),
              onTap: () {
                con.closeDrawer();
                // Routers.pushNamed(context, "/payment");
                Routers.pushNamed(context, "/card_payment");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.restore_sharp,
                size: 25.sp,
                color: AppColors.primary,
              ),
              title: Text(
                "Ride History",
                style: TextStyle(fontSize: 17.sp),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.phone_forwarded_rounded,
                size: 25.sp,
                color: AppColors.primary,
              ),
              title: Text(
                "support",
                style: TextStyle(fontSize: 17.sp),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                size: 25.sp,
                color: AppColors.primary,
              ),
              title: Text(
                "About",
                style: TextStyle(fontSize: 17.sp),
              ),
            ),
            ListTile(
              onTap: () {
                AuthController().signOut(context);
              },
              leading: Icon(
                Icons.info_outline,
                size: 25.sp,
                color: AppColors.primary,
              ),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 17.sp),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 60,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        )
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future saveRequestToDataBase() async {

    databaseReference.child("UserRequest").set({
      'pick_address': pickLocationText,
      'pick_lat': lat,
      'pick_lng': long,

    });

  }

}
