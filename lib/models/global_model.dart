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

String googleApikey = "AIzaSyCV-cMBmwbrbTZSklLMnmq4aU3lTIHUJiE";
final databaseReference = FirebaseDatabase.instance.ref();
