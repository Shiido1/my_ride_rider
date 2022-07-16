// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:my_ride/utils/router.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class RideArriver extends StatelessWidget {
//   const RideArriver({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   padding: EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Your Ride has arrived Pick up',
//                         style: TextStyle(
//                           fontSize: Adaptive.sp(17),
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 6,
//                       ),
//                       Text(
//                         'No 33, Boulevard Street',
//                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: Adaptive.sp(15)),
//                       ),
//                     ],
//                   ),
//                   decoration: BoxDecoration(
//                     color: Color(0XFF000B49),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 children: [
//                   Text(
//                     'Ride Details:',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//                   ),
//                   SizedBox(
//                     height: 14,
//                   ),
//                   Text('TOYOTA CAMRY'),
//                   SizedBox(
//                     height: 2,
//                   ),
//                   Text('Color: Blue'),
//                   SizedBox(
//                     height: 2,
//                   ),
//                   Text('Ride Details:'),
//                   Image.asset(
//                     "assets/images/car1.jpeg",
//                     height: 100,
//                   )
//                 ],
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 18),
//             child: Text(
//               'Note:',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   padding: EdgeInsets.all(10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Don't keep your driver waiting",
//                         style: TextStyle(
//                           fontSize: Adaptive.sp(14),
//                           color: Colors.red,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 4,
//                       ),
//                       Text(
//                         'He can cancel after 5mins and you will be charged \$5',
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontSize: Adaptive.sp(14),
//                         ),
//                       ),
//                     ],
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.black12,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   padding: EdgeInsets.all(10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "If you choose to cancel trip after the driver has arrived destination, you will be charged \$5",
//                         style: TextStyle(
//                           fontSize: Adaptive.sp(14),
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.black12,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Routers.pushNamed(context, "/trip_stated");
//                     },
//                     child: Container(
//                       width: 180,
//                       height: 49,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                         color: Color(0XFF000B49),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Ok',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Routers.replaceAllWithName(context, "/home");
//                     },
//                     child: Text(
//                       'Cancel Request',
//                       style: TextStyle(
//                         color: Colors.red,
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           )
//         ],
//       )),
//     );
//   }
// }
