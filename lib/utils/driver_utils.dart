import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ride/controllers/auth_controller.dart';

import '../models/driver.model.dart';
import 'dart:math' as math_math;

AuthController authController = AuthController();

class DriversUtil {
  static double? rounded;
  static DriversInformations returnClosest(
      LatLng pickUpLoc, List<DriversInformations> drivers) {
    List mapList = [];

    if (drivers.isNotEmpty) {
      for (var d in drivers) {
        double distanceInMeters = getDistanceFromLatLonInKm(
            pickUpLoc.latitude,
            pickUpLoc.longitude,
            double.parse(d.location![0].toString()),
            double.parse(d.location![1].toString()));

        rounded = dp(distanceInMeters, 5);
        Map map = {"id": d.id, "distance": rounded, "name": d.name};
        mapList.add(map);
      }
      Map secondMap = mapList.reduce((value, element) =>
          value["distance"] < element["distance"] ? value : element);

      DriversInformations driversInformation =
          drivers.where((element) => element.id == secondMap["id"]).first;
      return driversInformation;
    }
    return DriversInformations();
  }

  static double dp(double val, int places) {
    num mod = math_math.pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  //HaverSine formula
  static double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = math_math.sin(dLat / 2) * math_math.sin(dLat / 2) +
        math_math.cos(deg2rad(lat1)) *
            math_math.cos(deg2rad(lat2)) *
            math_math.sin(dLon / 2) *
            math_math.sin(dLon / 2);
    var c = 2 * math_math.atan2(math_math.sqrt(a), math_math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  static double deg2rad(deg) {
    return deg * (math_math.pi / 180);
  }
}
