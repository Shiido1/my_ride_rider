import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/controllers/firebase_connector.dart';
import 'package:my_ride/models/trip_model.dart';
import 'package:my_ride/repository/trip_repo.dart';
import 'package:my_ride/schemas/user.dart';
import 'package:my_ride/states/trip_state.dart';
import 'package:provider/src/provider.dart';
import 'package:my_ride/states/auth_state.dart';

class TripController extends ControllerMVC {
  factory TripController([StateMVC? state]) => _this ??= TripController._(state);
  TripController._(StateMVC? state)
      : model = TripModel(),
        super(state);
  static TripController? _this;

  final TripModel model;

  TripRepo tripRepo = TripRepo();
  FirebaseConnector connector = FirebaseConnector();

  /*Future<void> getActiveDrivers() async{
    setState(() {
      model.isLoading = true;
    });

     var pickLong = 0.099999999;
     var pickLat = 0.888888888;
     var dropLong = 0.777777777;
     var dropLat = 0.666666666;
     String pickAddress = "wuse2";
     String dropAddress = "Bannex";
     String vehicleType = "23434dff556gg77777hh888";
     String paymentOption = "1";
     String driverid = "123456";

     bool response = await tripRepo.getActiveDriver({"pick_lat": pickLat, "pick_Lng": pickLong,
       "drop_lat": dropLat, "drop_lng": dropLong, "vehicle_type": vehicleType, "pick_address": pickAddress,
     "drop_address": dropAddress, "drivers": driverid, "payment_options": paymentOption });

     if(response != null && response == true){

       print("Response Vale: $response");
       TripProvider provider = state!.context.read<TripProvider>();

       connector.listenForCreatedTrip(model.selectedCar.driverId, model.selectedCar.tripSessionId).listen((event) {

       });

     }else{

     }
  }*/

  Future<void> getAvailableRides() async {
    setState(() {
      model.isLoading = true;
    });
    bool response = await tripRepo.getAvailableRide({
      "pickUpLocation": {"lat": 8.99790063307103, "long": 7.477790525717647, "displayName": "Durumi"},
      "destLocation": {"lat": 51.477928, "long": -0.001545, "displayName": "Nomad Generation"}
    });

    //it the api response is TRUE, start listen to firebase to get available vehicles
    if (response == true) {
      User user = state!.context.read<AuthProvider>().user;
      TripProvider provider = state!.context.read<TripProvider>();
      // provider.availableVehicles = await connector.getDriverInformation(user.id!);
    } else {}

    setState(() {
      model.isLoading = false;
    });
  }

  Future<void> requestRide() async {
    setState(() {
      model.isLoading = true;
    });
    bool response = await tripRepo.requestRide({"tripSessionId": "Tm1eTtF3RLXsnHjyKjMZ"});

    //it the api response is TRUE, start listen to firebase to get available vehicles
    if (response == true) {
      User user = state!.context.read<AuthProvider>().user;
      TripProvider provider = state!.context.read<TripProvider>();

     connector.listenToTripCreation(model.selectedCar.driverId).listen((event) {
        print("griverid: $event");

      });


     /* connector.listenToTripCreation(model.selectedCar.driverId, model.selectedCar.tripSessionId).listen((event) {

      });
*/
      // provider.availableVehicles = await connector.getDriverInformation(user.id!);
    } else {}

    setState(() {
      model.isLoading = false;
    });
  }
}
