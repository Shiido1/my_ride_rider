import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

import '../models/trip_model.dart';
import '../repository/trip_repo.dart';
import '../schemas/user.dart';
import '../states/auth_state.dart';
import '../states/trip_state.dart';
import 'firebase_connector.dart';

class RideController extends ControllerMVC {
  factory RideController([StateMVC? state]) => _this ??= RideController._(state);
  RideController._(StateMVC? state)
      : model = TripModel(),
        super(state);
  static RideController? _this;

  TripModel model;

  TripRepo tripRepo = TripRepo();
  FirebaseConnector connector = FirebaseConnector();

  Future<void> getActiveRides() async {
    setState(() {
      model.isLoading = true;
    });
    bool response = await tripRepo.getActiveRide({
      "isAvailable": "1",
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

  Future<void> createRideRequest() async {
    setState(() {
      model.isLoading = true;
    });
    bool response = await tripRepo.createRideRequest({"tri": "Tm1eTtF3RLXsnHjyKjMZ"});

    //it the api response is TRUE, start listen to firebase to get available vehicles
    if (response == true) {
      User user = state!.context.read<AuthProvider>().user;
      TripProvider provider = state!.context.read<TripProvider>();

      connector.listenToTripCreation(model.selectedCar.driverId).listen((event) {

      });

      // provider.availableVehicles = await connector.getDriverInformation(user.id!);
    } else {}

    setState(() {
      model.isLoading = false;
    });
  }
}
