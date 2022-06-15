import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/utils/local_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../utils/router.dart';

class HomeSearchDestination extends StatefulWidget {
  const HomeSearchDestination({Key? key}) : super(key: key);

  @override
  _HomeSearchDestinationState createState() => _HomeSearchDestinationState();
}

class _HomeSearchDestinationState extends State<HomeSearchDestination> {

  String googleApikey = "AIzaSyAaF3Z1gioxA2z3_7kwD9nyDu1nhFcaT8U";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(9.072264, 7.491302);
  String destinationAddress = "Enter Drop Location";
  final databaseReference = FirebaseDatabase.instance.ref();

  double? lat;
  double? long;

  @override
  Widget build(BuildContext context) {
     var pickVal = LocalStorage().fetch("locateKey");
    return Scaffold(body: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          height: 250,
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
              const SizedBox(
                height: 10,
              ),
              Text(
                " Your Pickup Location",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
              Text("PickUpLocation",
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 70,),
              Row(children: [Container(child: Text("Change Location",
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ),SizedBox(width: 10,),
                Container(child: Icon(Icons.arrow_forward, size: 20, color: Colors.white,),)],),],),),

              Container(
                height: Adaptive.h(100) - 250,
                padding: EdgeInsets.symmetric(horizontal: Adaptive.w(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                destinationAddress = place.description.toString();
                              });
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
                              mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
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
                              child: Text(
                                destinationAddress,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              saveDestRequest();
                              Routers.pushNamed(context, '/select_ride');
                            },
                            child: Container(
                              child: Icon(Icons.search),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      'History',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView (
                        children: [

                           InkWell(onTap: () {_showModalBottomSheet();},
                            child: Card( color: Colors.blueGrey[100], child:Padding(padding: EdgeInsets.all(10.0),
                              child: Row(
                                children:[const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,
                                  ),
                                  radius: 15,
                                ),SizedBox(width: 20),
                                  Column(children: [const Text("Bannex Plaza"), Text("Wuse zone 2")], ) ],),),),),
                          InkWell(onTap: () {_showModalBottomSheet();},
                            child: Card( color: Colors.blueGrey[100], child:Padding(padding: EdgeInsets.all(10.0),
                              child: Row(
                                children:[const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,
                                  ),
                                  radius: 15,
                                ),SizedBox(width: 20),
                                  Column(children: [const Text("Bannex Plaza"), Text("Wuse zone 2")], ) ],),),),
                          ),
                          InkWell(onTap: () {_showModalBottomSheet();},
                            child: Card( color: Colors.blueGrey[100], child:Padding(padding: EdgeInsets.all(10.0),
                              child: Row(
                                children:[const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.white,
                                  ),
                                  radius: 15,
                                ),SizedBox(width: 20),
                                  Column(children: [const Text("Bannex Plaza"), Text("Wuse zone 2")], ) ],),),),
                          ),

                        ],
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(height: 40, decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.black),
                bottom: BorderSide(width: 2.0, color: Colors.white),
              ),
              color: Colors.white,
            ), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Icon(Icons.location_on_rounded, color: Colors.red,),
              Text("View on Map", style: TextStyle(color: Colors.black, fontSize: 15),)
            ],
            ),),
          ),
        ),
            ],
          ),
        );
  }

  todoFunc() {}

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
             decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
             child: Column(
               children: [
                 Container(
                   height: 180,
                   padding: const EdgeInsets.all(10),
                   decoration: BoxDecoration(border: Border.all(color: AppColors.primary), borderRadius: const BorderRadius.all(Radius.circular(20))),
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
                            // controller: con.model.pickupController,
                             decoration: Constants.defaultDecoration.copyWith(
                               labelText: "FROM",
                             ),
                             onTap: () {
                               setState(() {
                             //    con.model.focusInput = "pickup";
                               });
                             },
                           ),
                           SizedBox(height: 20),
                           TextFormField(
                           //  controller: con.model.destinationController,
                             decoration: Constants.defaultDecoration.copyWith(
                               labelText: "TO",
                             ),
                             onTap: () {
                               setState(() {
                           //      con.model.focusInput = "destination";
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
             ),);
         },
       );
   }

  void saveDestRequest() async {
    databaseReference.child("UserRequest").set({
      'drop_address': destinationAddress,
      'drop_lat': lat,
      'drop_lng': long,

    });
  }
}
