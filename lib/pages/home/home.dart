import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/constants/session_manager.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:my_ride/controllers/home_controller.dart';
import 'package:my_ride/models/global_model.dart';
import 'package:my_ride/partials/mixins/validations.dart';
import 'package:my_ride/utils/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../widget/text_form_field.dart';

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
  // int _selectedIndex = 0;

  final databaseReference = FirebaseDatabase.instance.ref();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  TextEditingController? pickupController =
      TextEditingController(text: 'Enter pickup location');

  Position? _currentPosition;
  String? _currentAddress = '';

  _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
      print('print location $_currentAddress');
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.street},${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    pickupController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawerEnableOpenDragGesture: false,
          key: scaffoldKey,
          endDrawer: Drawer(
            child: drawerWidget(),
          ),
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.w),
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
                        InkWell(
                          onTap: () =>
                              scaffoldKey.currentState!.openEndDrawer(),
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
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const CircularProgressIndicator(),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Hi there",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Select your pickup location',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 7.h,
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
                            pickUpLocationAdd =
                                place.description ?? _currentAddress;
                            pickupController = TextEditingController(
                                text: pickUpLocationAdd ?? _currentAddress);
                          });
                          //form google_maps_webservice package
                          final plist = GoogleMapsPlaces(
                            apiKey: googleApikey,
                            apiHeaders:
                                await const GoogleApiHeaders().getHeaders(),
                          );
                          String placeid = place.placeId ?? "0";
                          final detail =
                              await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          pickUpLat = geometry.location.lat.toString();
                          pickUpLong = geometry.location.lng.toString();
                        }
                      },
                      readOnly: true,
                      controller: pickupController,
                      suffixWidget: InkWell(
                          onTap: () {
                            Routers.pushNamed(context, '/home_search_dest');
                          },
                          child: const Icon(Icons.search)),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 3.w),
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
                          SizedBox(
                            width: 2.w,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                pickupController = TextEditingController(
                                    text: _currentAddress);
                              });
                            },
                            child: Container(
                              width: 68.w,
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
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '$_currentAddress',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Add place',
                          style: TextStyle(
                            fontSize: 15.sp,
                            // fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const Icon(
                          Icons.add,
                          color: Colors.green,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Nearest pickup location',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 32.h,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return nearSavedLoacation();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Routers.pushNamed(context, "/schedule_page");
                },
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  margin: EdgeInsets.fromLTRB(60.w, 5.w, 8.w, 10.w),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Book ride',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              )
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
          )),
    );
  }

  nearSavedLoacation() => InkWell(
        onTap: () {
          // _showModalBottomSheet();
        },
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

  drawerItem({String? text, IconData? icon, Function()? onTap}) => Padding(
        padding: EdgeInsets.only(left: 3.w),
        child: ListTile(
          leading: Icon(
            icon!,
            size: 22.sp,
            color: AppColors.primary,
          ),
          title: Text(
            "$text",
            style: TextStyle(fontSize: 17.sp),
          ),
          onTap: onTap,
        ),
      );

  Widget drawerWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 32,
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
                      Padding(
                        padding: EdgeInsets.only(top: 1.w, left: 3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User Name',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                con.closeDrawer();
                                Routers.pushNamed(context, "/edit_profile");
                              },
                              child: Text(
                                'Edit profile',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[800],
                                  size: 16.sp,
                                ),
                                Text(
                                  '4.0',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: con.closeDrawer, icon: const Icon(Icons.close))
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: AppColors.bgGrey1,
            ),
            SizedBox(
              height: 2.5.h,
            ),
            drawerItem(
                icon: Icons.payment,
                text: "Payment",
                onTap: () => Routers.pushNamed(context, "/card_payment")),
            drawerItem(
                icon: Icons.restore_sharp, text: "Ride History", onTap: () {}),
            drawerItem(
                icon: Icons.phone_forwarded_rounded,
                text: "Support",
                onTap: () {}),
            drawerItem(icon: Icons.info_outline, text: "About", onTap: () {}),
            drawerItem(
                icon: Icons.logout,
                text: "Logout",
                onTap: () => AuthController().signOut(context)),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20.w),
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 43,
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
}
