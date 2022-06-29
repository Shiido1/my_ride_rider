import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/driver.model.dart';
import 'dart:math' as Math;

class DriversUtil {
  static DriversInformations returnClosest(
      LatLng pickUpLoc, List<DriversInformations> drivers) {
    List mapList = [];

    if (drivers.isNotEmpty) {
      for (var d in drivers) {
        double distanceInMeters = getDistanceFromLatLonInKm(
            pickUpLoc.latitude,
            pickUpLoc.longitude,
            double.parse(d.location![0]),
            double.parse(d.location![1]));

        final rounded = dp(distanceInMeters, 5);
        // map[d.name] = rounded;
        Map map = {"id": d.id, "distance": rounded, "name": d.name};
        mapList.add(map);
      }
      print('printing closest: $mapList');
      Map secondMap = mapList.reduce((value, element) =>
          value["distance"] < element["distance"] ? value : element);
      print('print second map: $secondMap');

      DriversInformations driversInformations =
          drivers.where((element) => element.id == secondMap["id"]).first;

      print('print drivers info :$driversInformations');

      return driversInformations;
    }
    return DriversInformations();
  }

  static double dp(double val, int places) {
    num mod = Math.pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  //HaverSine formula
  static double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  static double deg2rad(deg) {
    return deg * (Math.pi / 180);
  }
}
