import 'package:flutter/material.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/utils/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0, bottom: 50, top: 0),
              child: Row(
                children: const [
                  Text(
                    'My Ride',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset('assets/images/car_red_success.png', fit: BoxFit.scaleDown),
            ),
            const SizedBox(height: 40),
            Text(
              "At my ride.com, we offer quality corporative and private transportation service across the entire metro Atlanta area at reasonable price. We know that in today's world, time is money. That's why we promise to get you wherever you are going on time, every time.",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 30),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Note: \n",
                children: [
                  TextSpan(
                    text: "iPhone users can call ",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: 'customer care',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textGreen10,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: '\nto register and book rides',
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, right: Adaptive.w(15), left: Adaptive.w(15)),
              child: ElevatedButton(
                onPressed: () {

                 Routers.pushNamed(context, '/phone_page');


                },
                child: const Text("Get Started"),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
                  backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(.3)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Routers.pushNamed(context, '/signin');
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.textGreen10,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
