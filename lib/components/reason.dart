// import 'package:flutter/material.dart';
// import 'package:my_ride/utils/router.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class Reason extends StatefulWidget {
//   const Reason({Key? key}) : super(key: key);

//   @override
//   _ReasonState createState() => _ReasonState();
// }

// class _ReasonState extends State<Reason> {
//   final List<String> reasons = [
//     'Driver went the wrong direction',
//     'Plate Number on app is different',
//     "Car color on app doesn't match",
//     "Driver's picture doesn't match",
//     "Driver took too much time",
//     'Faulty Vehicle',
//     'Ordered by mistake',
//     'I put the wrong location',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20, bottom: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Reason for canceling',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: Adaptive.sp(18)),
//                 ),
//                 Icon(Icons.cancel_sharp)
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           ListView.separated(
//             scrollDirection: Axis.vertical,
//             shrinkWrap: true,
//             itemCount: reasons.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 onTap: () {
//                   Routers.replaceAllWithName(context, "/home");
//                 },
//                 title: Text(
//                   reasons[index],
//                   textAlign: TextAlign.start,
//                   style: TextStyle(color: Colors.black, fontSize: 15),
//                 ),
//               );
//             },
//             separatorBuilder: (BuildContext context, int index) => const Padding(
//               padding: EdgeInsets.only(left: 16.0, right: 16.0),
//               child: Divider(
//                 color: Colors.black45,
//                 height: 0.1,
//               ),
//             ),
//           ),
//           // SizedBox(
//           //   height: 30,
//           // ),
//           // InkWell(
//           //   child: Container(
//           //     width: 180,
//           //     height: 40,
//           //     decoration: BoxDecoration(color: Color(0XFF000B49), borderRadius: BorderRadius.all(Radius.circular(10))),
//           //     child: Center(
//           //       child: Text(
//           //         'OK',
//           //         style: TextStyle(color: Colors.white, fontSize: 16),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
