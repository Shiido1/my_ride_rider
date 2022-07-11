// // ignore: file_names
// import 'package:flutter/material.dart';
// import 'package:my_ride/schemas/available_car.dart';

// class TripProvider extends ChangeNotifier {
//   Map<String, dynamic?> _availableVehicles = {};

//   //GETTERS
//   Map<String, dynamic?> get availableVehicles => _availableVehicles;
//   // User get user => _user;

//   //SETTERS
//   set availableVehicles(Map<String, dynamic?> info) {
//     print(info);
//     info.forEach((key, value) {
//       _availableVehicles[key] =
//           AvailableCars.fromJson(Map<String, dynamic>.from(value));
//     });

//     notifyListeners();
//   }
// }
