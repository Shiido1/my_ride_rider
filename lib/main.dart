import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';
import 'package:my_ride/App.dart';
import 'package:my_ride/constants/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  initialize();

  runApp(const App());
}

void initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
 // String path;
  var path = Directory.current.path;
  Stripe.publishableKey = Constants.stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.com.myride.user';
  await Stripe.instance.applySettings();
  // await Stripe.instance.applySettings();

  ///get storage permission
  // PermissionStatus? status = await Permission.storage.status;
  // if (status == null || !status.isGranted) {
  //   await Permission.storage.request();
  // }

  // PermissionStatus? statusCamera = await Permission.camera.status;
  // if (!statusCamera.isGranted) {
  //   await Permission.camera.request();
  // }
  await Firebase.initializeApp();

  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
 // Hive..init(path);
}
