import 'package:firebase_database/firebase_database.dart';

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

String? cardno;
String? cardHolder;
String? cvv;
String? month;
String? year;
bool? isRegistration;

String googleApikey = "AIzaSyCV-cMBmwbrbTZSklLMnmq4aU3lTIHUJiE";
final databaseReference = FirebaseDatabase.instance.ref();


DatabaseReference snapshot1 = FirebaseDatabase.instance.ref('drivers');

up({path, status}) async {
  await snapshot1.child(path).update(updatefb(status: status));
}

Map<String, dynamic> updatefb({String? status}) => {
      'status': status,
};
