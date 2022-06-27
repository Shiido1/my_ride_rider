import 'package:flutter/material.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CardPayment extends StatelessWidget {
  const CardPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: AppColors.primary),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 130,
            color: AppColors.primary,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            CircleAvatar(
                              radius: 25,
                            ),
                          ],
                        ),
                        SizedBox(height: 5.w),
                        Text(
                          'Card',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
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
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [Text('Amount')],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              '\$2',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 26),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black26),
                          borderRadius: BorderRadius.all(Radius.circular(3.w))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: const [Text('Card 4567')],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Card',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.sp),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Accepted Cards',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                              color: Colors.black38),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 34.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: AssetImage(
                                        'assets/images/Mastercard.png')),
                                border:
                                    Border.all(width: 1, color: Colors.black26),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.w))),
                            child: const SizedBox(),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            width: 34.w,
                            height: 7.h,
                            padding: EdgeInsets.all(2.w),
                            child: Image.asset(
                              'assets/images/visa.png',
                              height: 20,
                              fit: BoxFit.fitWidth,
                            ),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black26),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.w))),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Card No',
                        labelStyle: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 7.w, right: 9.w),
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
                    padding: EdgeInsets.only(left: 7.w, right: 70.w),
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
                    height: 9.h,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 220,
                        height: 50,
                        decoration:
                            const BoxDecoration(color: Color(0XFF000B49)),
                        child: Center(
                          child: Text(
                            'Continue',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
