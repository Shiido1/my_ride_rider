import 'package:flutter/material.dart';
import 'package:my_ride/components/my_app_bar.dart';
import 'package:my_ride/components/dismisskeyboard.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/partials/mixins/validations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddCardPage extends StatefulWidget {
  AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> with ValidationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.defaultAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5), vertical: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Adaptive.h(100) - 100,
            child: DismissKeyboard(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Add Card',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(
                        Icons.lock,
                        color: AppColors.primary,
                        size: 22,
                      ),
                      const SizedBox(height: 5),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "We would never share your card \n",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                          children: [
                            TextSpan(
                              text: "information with anyone",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, right: Adaptive.w(5), left: Adaptive.w(5)),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Add Card"),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
                            backgroundColor: MaterialStateProperty.all(AppColors.primary),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
