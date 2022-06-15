import 'package:flutter/material.dart';
import 'package:my_ride/schemas/available_car.dart';

class TripModel {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  AvailableCars selectedCar = AvailableCars();

  TextEditingController destinationController = TextEditingController();

  TextEditingController pickupController = TextEditingController();
}
