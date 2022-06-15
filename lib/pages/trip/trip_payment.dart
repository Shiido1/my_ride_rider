import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TripPayment extends StatelessWidget {
  const TripPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: AppColors.primary),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 130,
          color: AppColors.primary,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 25,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Card',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 100.h - 210,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text('Amount')],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '\$2',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration:
                        BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [Text('Card 4567')],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Card',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Accepted Cards',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black38),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(fit: BoxFit.fitHeight, image: AssetImage('assets/images/Mastercard.png')),
                              border: Border.all(width: 1, color: Colors.black26),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: Center(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/visa.png',
                            height: 20,
                            fit: BoxFit.fitWidth,
                          ),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.all(Radius.circular(5))),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 120,
                          height: 50,
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/paypal.png',
                            height: 30,
                            fit: BoxFit.fitHeight,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black26),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Card No',
                      labelStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      labelStyle: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 300),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Cvv',
                      labelStyle: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 220,
                      height: 50,
                      decoration: BoxDecoration(color: Color(0XFF000B49)),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
