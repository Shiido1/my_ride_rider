import 'package:flutter/material.dart';
import 'package:my_ride/components/ride_arrival.dart';
import 'package:my_ride/components/reason.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({Key? key}) : super(key: key);

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  void initState() {
    super.initState();

    delayAndMoveToNextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: Adaptive.h(60),
          ),
          Stack(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 40,
                        child: Icon(
                          Icons.phone_outlined,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.white)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 30,
                        width: 40,
                        color: Colors.white,
                        child: Icon(
                          Icons.message,
                          color: Color(0XFF000B49),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 30,
                        width: 250,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            'Driver accepted Ride',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          height: 30,
                          width: 40,
                          child: Icon(Icons.location_on_rounded, size: 20, color: Colors.redAccent),
                          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.white))),
                    ],
                  ),
                ),
                height: 100,
                decoration: BoxDecoration(color: Color(0XFF000B49), borderRadius: BorderRadius.circular(30)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 3,
                          width: 60,
                          decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20)),
                        ),
                      )
                    ],
                  ),
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: Adaptive.w(30)),
              SizedBox(
                width: Adaptive.w(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ANTHONY JOSHUA',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('TOYOTA CAMRY'),
                    Text('CGL 1288'),
                    Text('Total No of rides: 51')
                  ],
                ),
              ),
              SizedBox(
                width: Adaptive.w(20),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[600],
                    ),
                    Text('4.0')
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              //  delayAndMoveToNextPage(context);
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(0),
                      content: SizedBox(
                        child: Reason(),
                        width: Adaptive.w(80),
                        height: 600,
                      ),
                    );
                  });
            },
            child: Text(
              'Cancel Request',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }

  void delayAndMoveToNextPage(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      showDialog(
          context: context,
          // barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: SizedBox(
                child: const RideArriver(),
                width: Adaptive.w(80),
                height: 600,
              ),
            );
          });
    });
  }
}
