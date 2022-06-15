import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:my_ride/components/my_app_bar.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    super.initState();
  }

  int step = 0;
  dynamic paymentIntentData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.defaultAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5), vertical: 10),
        child: SizedBox(
          height: Adaptive.h(100) - 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text("Zenith Bank"),
                      subtitle: Text("6746 **** **** 4536"),
                    ),
                    ListTile(
                      title: Text("Add new card"),
                      onTap: makePayment,
                    ),
                    CardField(

                      onCardChanged: (card) {
                        print(card);
                      },
                    ),
                    Stepper(
                      // controlsBuilder: emptyControlBuilder,
                      currentStep: step,
                      steps: [
                        Step(
                          title: Text('Init payment'),
                          content: ElevatedButton(
                            onPressed: initPaymentSheet,
                            child: Text('Init payment sheet'),
                          ),
                        ),
                        Step(
                          title: Text('Confirm payment'),
                          content: ElevatedButton(
                            onPressed: confirmPayment,
                            child: Text('Init payment sheet'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      )),
      builder: (context) {
        return SizedBox(
          height: 500,
          width: Adaptive.w(100),
          child: CardField(
            onCardChanged: (card) {
              print(card);
            },
          ),
        );
      },
    );
  }

  void initStripe() async {
    await Stripe.instance.createPaymentMethod(PaymentMethodParams.card());
  }

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    final url = Uri.parse('/payment-sheet');
    // final response = await http.post(
    //   url,
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    //   body: json.encode({
    //     'a': 'a',
    //   }),
    // );
    // final body = json.decode(response.body);
    // if (body['error'] != null) {
    //   throw Exception(body['error']);
    // }
    // return body;
    return {};
  }

  Future<void> makePayment() async {
    print("herer");
    String url = 'https://api.stripe.com/v1/payment_intents';

    final header = {
      'Content-Type': 'application/json',
      };
    Dio dio = Dio(BaseOptions(headers: header));
    try {
      // final Response response = await dio.get(url);
      // paymentIntentData = json.decode(response.data);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: 'ch_3KjfB0CX3GWfgrAW1raYkiLU',
        // applePay: true,
        // customerId: null,
        // googlePay: true,
        style: ThemeMode.light,
        merchantCountryCode: 'US',
        merchantDisplayName: 'Flutter Stripe Store Demo',
      ));
      print("herer");
      setState(() {});
      displayPaymentSheet();
    } catch (e) {
      print(e);
      displaySnackbar(e.toString());
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // await Stripe.instance.presentPaymentSheet(
      //   parameters: PresentPaymentSheetParameters(
      //     clientSecret: paymentIntentData?['paymentIntent'] ?? '',
      //     confirmPayment: true,
      //   ),
      // );

      setState(() {
        paymentIntentData = null;
      });
      displaySnackbar('Payment succesfully completed');
    } catch (e) {
      print(e);
      displaySnackbar(e.toString());
    }
  }

  void displaySnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      // final data = await _createTestPaymentSheet();

      // create some billingdetails
      final billingDetails = BillingDetails(
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mocked data for tests

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Main params
          paymentIntentClientSecret: "ch_3KjfB0CX3GWfgrAW1raYkiLU",
          merchantDisplayName: 'Flutter Stripe Store Demo',
          // Customer params
          customerId: "hdgegeyeu736372",
          customerEphemeralKeySecret: "hdggetetetete",
          // Extra params
          applePay: true,
          googlePay: true,
          style: ThemeMode.dark,
          primaryButtonColor: Colors.redAccent,
          billingDetails: billingDetails,
          testEnv: true,
          merchantCountryCode: 'DE',
        ),
      );
      setState(() {
        step = 1;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  Future<void> confirmPayment() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      setState(() {
        step = 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment succesfully completed'),
        ),
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: ${e}'),
          ),
        );
      }
    }
  }
}
