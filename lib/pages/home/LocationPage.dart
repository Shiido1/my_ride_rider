// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';


// class LocationPage extends StatefulWidget {
//   const LocationPage({Key? key}) : super(key: key);

//   @override
//   _LocationPageState createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
//   final Completer<GoogleMapController> _mapController =
//   Completer<GoogleMapController>();


//   @override
//   Widget build(BuildContext context) {

//     final Size size = MediaQuery
//         .of(context)
//         .size;
//     return Stack(
//       children: [
//         GoogleMap(
//           onMapCreated: (GoogleMapController controller) =>
//               _mapController.complete(),
//           initialCameraPosition: CameraPosition(
//             target: LatLng(0.0, 0.0),
//           ),
//         ),
//         Positioned(
//             top: 10,
//             left: size.width * 0.1,
//             right: size.width * 0.1,
//             child: Container(
//               width: size.width * 0.8,
//               child: AddressSearchField(
//                   onDone: (point) async {
//                     if (_mapController.isCompleted &&
//                         point.found) {
//                       await (await _mapController.future)
//                         .moveCamera(CameraUpdate.newCameraPosition(
//                         CameraPosition(
//                             target: LatLng(point.latitude, point.latitude))));
//                     } debugPrint("MapController: $CameraPosition");
//                   }

//               ),

//             ), ),

//       ],

//     );

//   }
// }

// AddressSearchField({String country: "equado",
// String noResultText: "noResult", required Future<Null>Function(dynamic point) onDone}) {
// }
