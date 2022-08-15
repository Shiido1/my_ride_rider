import 'package:flutter/material.dart';
import 'package:my_ride/pages/auth/signin/email_otp.dart';
import 'package:my_ride/pages/auth/signin/forgot_password.dart';
import 'package:my_ride/pages/auth/signin/reset_password.dart';
import 'package:my_ride/pages/auth/signin/signin.dart';
import 'package:my_ride/pages/auth/signup/contact_info.dart';
import 'package:my_ride/pages/auth/signup/otp_page.dart';
import 'package:my_ride/pages/auth/signup/phone_page.dart';
import 'package:my_ride/pages/home/change_dest_page.dart';
import 'package:my_ride/pages/home/home.dart';
import 'package:my_ride/pages/home/home_search_dest_page.dart';
import 'package:my_ride/pages/payment/add_card_page.dart';
import 'package:my_ride/pages/payment/card.dart';
import 'package:my_ride/pages/profile/edit_profile.dart';
import 'package:my_ride/pages/profile/edit_profile_screen.dart';
import 'package:my_ride/pages/profile/profile.dart';
import 'package:my_ride/pages/auth/signup/regSuccessPage.dart';
import 'package:my_ride/pages/schedule/schedule.dart';
import 'package:my_ride/widget/rate_screen.dart';
import '../pages/trip/schedule_tirp_vehicle_type.dart';
import '../pages/trip/select_ride.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/phone_page':
      return MaterialPageRoute(builder: (_) => const PhoneNumberPage());
    case '/otp_page':
      return MaterialPageRoute(builder: (_) => const OTPPage());
    case '/contact_info':
      return MaterialPageRoute(builder: (_) => const ContactInfoPage());
    case '/signin':
      return MaterialPageRoute(builder: (_) => const SignInPage());
    case '/home':
      return MaterialPageRoute(builder: (_) => const HomePage());
    case '/profile':
      return MaterialPageRoute(builder: (_) => const ProfilePage());
    case '/select_ride':
      return MaterialPageRoute(builder: (_) => const SelectRide());
    case '/schedule_page':
      return MaterialPageRoute(builder: (_) => const SchedulePage());
    case '/card_payment':
      return MaterialPageRoute(builder: (_) => const CardPayment());
    case '/reg_success':
      return MaterialPageRoute(builder: (_) => const RegistrationSuccess());
    case '/home_search_dest':
      return MaterialPageRoute(builder: (_) => const HomeSearchDestination());
    case '/add_card':
      return MaterialPageRoute(builder: (_) => const AddCard());
    case '/edit_profile':
      return MaterialPageRoute(builder: (_) => const EditProfileScreen());
    case '/ratings':
      return MaterialPageRoute(builder: (_) => const RateScreen());
    case '/forgot':
      return MaterialPageRoute(builder: (_) => const ForgotPassword());
    case '/email_otp':
      return MaterialPageRoute(builder: (_) => const EmailOtp());
    case '/reset_password':
      return MaterialPageRoute(builder: (_) => const ResetPassword());
    case '/change_destination_location':
      return MaterialPageRoute(
          builder: (_) => const ChangeDestinationLocation());
    case '/schedule_trip_vehicle':
      return MaterialPageRoute(
          builder: (_) => const ScheduleTripVehicle());
    case '/edit':
      return MaterialPageRoute(
          builder: (_) => const EditProfileScreen2());

    default:
      return MaterialPageRoute(builder: (_) => Container());
  }
}
