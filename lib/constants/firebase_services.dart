import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../widget/custom_schedule_trip_dialog.dart';

final firebaseClass = FirebaseClass();

class FirebaseClass {
  FirebaseClass();

  Future<void> _onOpenAppMessageOnBackground(context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
  }

  firebasePushNotification(context) {
    // _onOpenAppMessageOnBackground(context);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showDialog(
          context: context,
          builder: (BuildContext cntxt) {
            return CustomScheduleRideDialog(
              pickAddress: message.data["pick_location"] ?? "",
              dropAddress: message.data["drop_location"] ?? '',
              tripTime: message.data["start_trip"] ?? " ",
            );
          });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        showDialog(
          context: context,
          builder: (BuildContext cntxt) {
            return CustomScheduleRideDialog(
              pickAddress: message.data["pick_location"] ?? "",
              dropAddress: message.data["drop_location"] ?? '',
              tripTime: message.data["start_trip"] ?? " ",
            );
          });
      }
    });
  }
}
