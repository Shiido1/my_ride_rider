// import 'package:cloud_firestore/cloud_firestore.dart';


// class FirebaseConnector {

//   Future<Map<String, dynamic>> getDriverInformation(String userId) async {
//     dynamic classic = await getClosestDriverBaseOnCategory(userId, "classic");
//     dynamic executive = await getClosestDriverBaseOnCategory(userId, "executive");
//     dynamic corporate = await getClosestDriverBaseOnCategory(userId, "corporate");

//     return {
//       "classic": classic,
//       "executive": executive,
//       "corporate": corporate,
//     };
//   }

//   dynamic getDriverDetails(String userId, String vehicleType) async {
//     Query ref = FirebaseFirestore.instance
//         .collection('drivers')
//         .where("driverid", isEqualTo: userId)
//         .where("vehicle_type", isEqualTo: vehicleType);

//     dynamic response = {};

//     await ref.get().then<dynamic>((QuerySnapshot snapshot) async {
//       if (snapshot.docs.isNotEmpty) {
//         response = {"tripSessionId": snapshot.docs.first.id};
//         //  response = {...snapshot.docs.first.data(), "tripSessionId": snapshot.docs.first.id};
//       }
//     });

//     return response;
//   }

//   Stream<QuerySnapshot> listenForCreatedTrip(String? driverId, String? tripSessionId) {
//     Query ref = FirebaseFirestore.instance
//         .collection('tripNotifications')
//         .where("status", isEqualTo: "created")
//         .where("tripSessionId", isEqualTo: tripSessionId)
//         .where("driverId", isEqualTo: driverId)
//         .limit(1);

//     return ref.get().asStream();
//   }



//   dynamic getClosestDriverBaseOnCategory(String userId, String categoryName) async {
//     Query ref = FirebaseFirestore.instance
//         .collection('tripSessions')
//         .where("driverStatus.status", isEqualTo: "")
//         .where("carCategory", isEqualTo: categoryName)
//         .where("tripInitiator", isEqualTo: userId)
//         .orderBy("distToPickupLocation")
//         .limit(1);

//     dynamic response = {};

//     await ref.get().then<dynamic>((QuerySnapshot snapshot) async {
//       if (snapshot.docs.isNotEmpty) {
//         response = {"tripSessionId": snapshot.docs.first.id};
//       //  response = {...snapshot.docs.first.data(), "tripSessionId": snapshot.docs.first.id};
//       }
//     });

//     return response;
//   }

//   Stream<QuerySnapshot> listenToTripCreation(String? driverId) {
//     Query ref = FirebaseFirestore.instance
//         .collection('drivers')
//         .where("isAvailaible", isEqualTo: "0")
//         .where("driverId", isEqualTo: driverId)
//         .limit(1);
//     print("reeference: $ref");
//     return ref.get().asStream();
//   }

//  /* Stream<QuerySnapshot> listenToTripCreation(String? driverId, String? tripSessionId) {
//     Query ref = FirebaseFirestore.instance
//         .collection('tripNotifications')
//         .where("status", isEqualTo: "created")
//         .where("tripSessionId", isEqualTo: tripSessionId)
//         .where("driverId", isEqualTo: driverId)
//         .limit(1);

//     return ref.get().asStream();
//   }*/
// }
