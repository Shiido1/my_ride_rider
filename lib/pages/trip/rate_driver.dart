import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_ride/components/loading_button.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/constants/constants.dart';
import 'package:my_ride/utils/router.dart';
import 'package:rating_bar_flutter/rating_bar_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RateDriver extends StatelessWidget {
  const RateDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Routers.replaceAllWithName(context, "/home");
                    },
                    icon: Icon(Icons.close, color: AppColors.primary,))
              ],
            ),
            CircleAvatar(
              radius: 50,
            ),
            SizedBox(
              height: 28,
            ),
            Text(
              'Lona Chukwu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            Text('Help us improve your driving experience better'),
            SizedBox(
              height: 10,
            ),
            Text(
              'RATE THE DRIVER',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBarFlutter(
                  onRatingChanged: (rating) {},
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  halfFilledIcon: Icons.star_half,
                  isHalfAllowed: true,
                  filledColor: Colors.green,
                  emptyColor: AppColors.primary,
                  halfFilledColor: Colors.amberAccent,
                  size: 48,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 300,
                    height: 90,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26)),
                    child: TextField(
                      maxLines: 3,
                      minLines: 3,
                      cursorColor: AppColors.primary,
                      decoration: Constants.noneDecoration.copyWith(
                        hintText: 'Leave Comment...',
                        // co
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Would you like to leave a tip?',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Tip goes to the driver',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                amountButton(2),
                amountButton(4),
                amountButton(6),
                amountButton(8),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Adaptive.w(15)),
              child: LoadingButton(
                isLoading: false,
                label: "Submit",
                onPressed: () {
                  Routers.replaceAllWithName(context, "/home");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget amountButton(int price) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(border: Border.all(width: 1, color: AppColors.primary), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Text(
                '\$' + price.toString(),
                style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
