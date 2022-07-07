import 'package:flutter/material.dart';
import 'package:my_ride/pages/auth/signin/signin.dart';
import 'package:my_ride/pages/auth/signup/contact_info.dart';
import 'package:my_ride/pages/auth/signup/otp_page.dart';
import 'package:my_ride/pages/auth/signup/phone_page.dart';
// import 'package:my_ride/pages/home/LocationPage.dart';
import 'package:my_ride/pages/home/google_map_page.dart';
import 'package:my_ride/pages/home/home.dart';
import 'package:my_ride/pages/home/home_search_dest_page.dart';
import 'package:my_ride/pages/payment/add_card_page.dart';
import 'package:my_ride/pages/payment/card.dart';
import 'package:my_ride/pages/payment/payment.dart';
import 'package:my_ride/pages/profile/edit_profile.dart';
import 'package:my_ride/pages/profile/profile.dart';
import 'package:my_ride/pages/auth/signup/regSuccessPage.dart';
import 'package:my_ride/pages/schedule/schedule.dart';
import 'package:my_ride/pages/trip/rate_driver.dart';
import 'package:my_ride/pages/trip/trip_stated.dart';
import 'package:my_ride/pages/trip/confirm_order.dart';
import 'package:my_ride/widget/order.dart';
import 'package:my_ride/pages/trip/select_ride.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/phone_page':
      return MaterialPageRoute(builder: (_) => PhoneNumberPage());
    case '/otp_page':
      return MaterialPageRoute(builder: (_) => OTPPage());
    case '/contact_info':
      return MaterialPageRoute(builder: (_) => ContactInfoPage());
    case '/signin':
      return MaterialPageRoute(builder: (_) => SigninPage());
    case '/home':
      return MaterialPageRoute(builder: (_) => HomePage());
    case '/profile':
      return MaterialPageRoute(builder: (_) => ProfilePage());
    case '/select_ride':
      return MaterialPageRoute(builder: (_) => SelectRide());
    // case '/locationPage':
    //   return MaterialPageRoute(builder: (_) =>  LocationPage());
    case '/order':
      return MaterialPageRoute(builder: (_) => const Order());
    case '/confirm_order':
      return MaterialPageRoute(builder: (_) => const ConfirmOrder());
    case '/payment':
      return MaterialPageRoute(builder: (_) => PaymentPage());
    case '/trip_stated':
      return MaterialPageRoute(builder: (_) => const TripStarted());
    case '/rate_driver':
      return MaterialPageRoute(builder: (_) => const RateDriver());
    case '/schedule_page':
      return MaterialPageRoute(builder: (_) => SchedulePage());

    case '/card_payment':
      return MaterialPageRoute(builder: (_) => const CardPayment());
    case '/reg_success':
      return MaterialPageRoute(builder: (_) => const RegistrationSuccess());
    case '/home_search_dest':
      return MaterialPageRoute(builder: (_) => const HomeSearchDestination());

    case '/google_map_page':
      return MaterialPageRoute(builder: (_) => const GoogleMapPage());

    case '/add_card':
      return MaterialPageRoute(builder: (_) => const AddCard());

    case '/edit_profile':
      return MaterialPageRoute(builder: (_) => const EditProfileScreen());

    // case '/select_driver_screen':
    //   return MaterialPageRoute(builder: (_) => SelectedDriverScreen());

    default:
      return MaterialPageRoute(builder: (_) => Container());
  }
}
