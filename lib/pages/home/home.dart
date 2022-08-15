// ignore_for_file: unused_local_variable

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
import 'package:my_ride/models/provider.dart';
import 'package:my_ride/partials/mixins/validations.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../widget/custom_dialog.dart';
import '../../widget/text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> with ValidationMixin {
  _HomePageState() : super(HomeController()) {
    con = controller as HomeController;
  }

  late HomeController con;

  final databaseReference = FirebaseDatabase.instance.ref();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  TextEditingController? pickupController =
      TextEditingController(text: 'Enter pickup location');

  Position? _currentPosition;
  String? _currentAddress = '';

  _getCurrentLocation(context) async {
    bool serviceEnabled;
    LocationPermission permission;

// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CustomDialog();
            });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      throw (e);
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
      rethrow;
    }
  }

  @override
  void initState() {
    _getCurrentLocation(context);
    super.initState();
  }

  @override
  void dispose() {
    pickupController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GoogleApiProvider>(context, listen: false).getLocationHistory();
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
                                fontSize: 16.8.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 0.2.h,
                            ),
                            Text(
                              'minutes away',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () =>
                              scaffoldKey.currentState!.openEndDrawer(),
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
                        fontSize: 16.8.sp,
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
                      height: 5.h,
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
                          onError: (err) {},
                        );

                        if (place != null) {
                          setState(() {
                            pickUpLocationAdd = place.description;
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
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 3.w),
                      child: Row(
                        children: [
                          Container(
                            height: 10.h,
                            color: AppColors.primary,
                            padding: EdgeInsets.all(3.w),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  pickUpLat =
                                      _currentPosition!.latitude.toString();
                                  pickUpLong =
                                      _currentPosition!.longitude.toString();
                                  pickUpLocationAdd = _currentAddress;
                                  pickupController = TextEditingController(
                                      text: _currentAddress);
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.5.w, horizontal: 2.5.w),
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
                            fontWeight: FontWeight.w600,
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
                    TextView(
                      text: 'History',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                        height: 32.h,
                        child: Consumer<GoogleApiProvider>(
                            builder: (_, provider, __) {
                          if (provider.responses == null) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ));
                          }
                          if (provider.responses!["data"].isEmpty) {
                            return Center(
                              child: TextView(
                                text: 'No History',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: provider.responses!["data"].length,
                            itemBuilder: (context, index) {
                              return nearSavedLocation(
                                  text: provider.responses!["data"][index]
                                      ["pick_address"],
                                  long: provider.responses!["data"][index]
                                          ["pick_lng"]
                                      .toString(),
                                  lat: provider.responses!["data"][index]
                                          ["pick_lat"]
                                      .toString());
                            },
                          );
                        })),
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
              onTap: () {},
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

  nearSavedLocation({String? text, String? long, String? lat}) => InkWell(
        onTap: () {
          setState(() {
            pickUpLocationAdd = text!;
            pickupController!.text = text;
            pickUpLat = lat;
            pickUpLong = long;
          });
        },
        child: Container(
          padding: EdgeInsets.only(bottom: 1.6.w),
          child: Card(
            color: Colors.blueGrey[100],
            child: Padding(
              padding: EdgeInsets.all(2.w),
              child: Row(children: [
                const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Colors.white,
                  ),
                  radius: 15,
                ),
                SizedBox(width: 3.5.w),
                Expanded(
                  child: TextView(
                    text: text ?? "",
                    fontSize: 16.sp,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
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
          title: TextView(text: "$text", fontSize: 17.sp),
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
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SessionManager.instance.usersData["profile_picture"] ==
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
                    width: 1.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.w, left: 3.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: '${SessionManager.instance.usersData["name"]}'
                              .split(" ")
                              .first,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        InkWell(
                          onTap: () {
                            con.closeDrawer();
                            Routers.pushNamed(context, "/edit_profile");
                          },
                          child: TextView(
                            text: 'Edit profile',
                            fontSize: 16.sp,
                            color: AppColors.primary,
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
                  const Spacer(),
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
            drawerItem(icon: Icons.payment, text: "Payment", onTap: () {}
                // onTap: () => Routers.pushNamed(context, "/card_payment"),
                ),
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
