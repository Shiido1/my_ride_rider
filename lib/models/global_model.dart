import 'package:cron/cron.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

String? userId;
String? driversId;
String? pickUpLocationAdd;
String? dropLocationAdd;
String? pickUpLat;
String? currentLocation;
String? pickUpLong;
String? dropLat;
String? dropLong;
String? userImage;
String? userFbToken;
String? id, request, driverRequestID;
String? driverFname, vehicleNumber, vehicleColor, vehicleName;
String? token;
String? deviceToken;
String? schedulePickUpLocationAdd, scheduleDropLocationAdd, scheduleNotDate;
String? mobile;
String? noOfRides;
String? cardno;
String? cardHolder;
String? cvv;
String? month;
String? year;
String? costOfRide;
bool? isRegistration;
bool? isChangeLocationOnTap = false;
String? scheduleValue = '';
String? scheduleDate;
String? scheduleDate1;
List<String>? listOfDates = [];
String? timeText = 'Pick time';
final cron = Cron();

String googleApikey = "AIzaSyDpq4jCmcd49Vj4NkTtLvJGuRm7qMOywyM";

// String googleApikey = "AIzaSyBOuc6C1-JuIn5cQtzTMuGiLyAs9YHKikE";
// String googleApikey = "AIzaSyCV-cMBmwbrbTZSklLMnmq4aU3lTIHUJiE";
final databaseReference = FirebaseDatabase.instance.ref();

DatabaseReference snapshot1 = FirebaseDatabase.instance.ref('drivers');

up({path, status}) async {
  await snapshot1.child(path).update(updatefb(status: status));
}

Map<String, dynamic> updatefb({String? status}) => {
      'status': status,
    };

callNumber() async {
  await FlutterPhoneDirectCaller.callNumber(mobile!);
}
