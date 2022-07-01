import 'package:firebase_database/firebase_database.dart';

String? userId;
String? driversId;
String? pickUpLocationAdd;
String? dropLocationAdd;
String? pickUpLat;
String? pickUpLong;
String? dropLat;
String? dropLong;
String? userImage;
String? userFbToken;
String? id, request,driverRequestID;

String googleApikey = "AIzaSyCV-cMBmwbrbTZSklLMnmq4aU3lTIHUJiE";
final databaseReference = FirebaseDatabase.instance.ref();
