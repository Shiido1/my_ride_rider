import 'package:flutter/material.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/router.dart';

class RegistrationSuccess extends StatelessWidget {
  const RegistrationSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: Adaptive.h(30),
                color: AppColors.primary,
              ),
              Column(
                children: [
                  SizedBox(height: Adaptive.h(15)),
                  Text(
                    'Registration Successful !',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Thank you for choosing MyRide. For more \n information and questions about our services, \n kindly visit our site at',
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'www.myride.com.',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              top: Adaptive.h(30) - (Adaptive.w(45) / 2),
              left: Adaptive.w(55) / 2,
              child: Container(
                height: Adaptive.w(45),
                width: Adaptive.w(45),
                decoration: const BoxDecoration(
                  color: AppColors.textGreen10,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_outlined,
                  color: Colors.white,
                  size: Adaptive.w(25),
                ),
              )),
          Positioned(
            bottom: 50,
            right: Adaptive.w(20),
            left: Adaptive.w(20),
            top: Adaptive.h(100) - 100,
            child: ElevatedButton(
              onPressed: () {
                Routers.pushNamed(context, '/home');
              },
              child: const Text("Home page"),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
                backgroundColor: MaterialStateProperty.all(AppColors.primary),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
