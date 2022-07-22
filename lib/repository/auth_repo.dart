import 'package:dio/dio.dart';
import 'package:my_ride/constants/session_manager.dart';
import 'package:my_ride/utils/services.dart';

class AuthRepo with Services {
  Future<Map<String, dynamic>?> sendPushNot(
      Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response =
        await apiFcmPostRequests("send", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> login(Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("user/login", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> register(
      Map<String, String> credentials) async {
    Response? response =
        await apiPostRequests("user/register", credentials);

    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Response?> phoneVerification(
      Map<String, String> credentials) async {
   Response? response =
        await apiPostRequests("user/register/send-otp", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> resetPassword(
      Map<String, String> credentials) async {
    Response? response =
    await apiPostRequests("password/reset", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> otpVerification(
      Map<String, dynamic> credentials) async {
    Response? response =
        await apiPostRequests("user/register/validate-otp", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> emailOtpVerification(
      Map<String, dynamic> credentials) async {
    Response? response =
    await apiPostRequests("password/validate-token", credentials);

    if (response != null) {

      return response;
    }

    return null;
  }
  Future<Response?> forgotPassword(
      Map<String, dynamic> credentials) async {
    Response? response = await apiPostRequests("password/forgot", credentials);
    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    Map<String, dynamic>? response = await apiGetRequests("user/");

    if (response != null) {
      SessionManager.instance.usersData = response;
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> getLocationHistory() async {
    Map<String, dynamic>? response = await apiGetRequests("request/user-completed-trips");

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> profilePicture(
      Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response =
        await apiUploadPostRequests("user/update-profile-picture", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> instantTrip(
      Map<String, dynamic> credentials) async {
    Response? response =
        await apiPostRequests("request/create", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> scheduleTrip(
      Map<String, dynamic> credentials) async {
    Response? response =
        await apiPostRequests("request/create", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> payment(
      Map<String, dynamic> credentials) async {
    Response? response =
        await apiPostRequests("payment/stripe/add/card", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> cancelTrip(
      Map<String, dynamic> credentials) async {
    Response? response =
        await apiPostRequests("request/cancel", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> changeLocation(
      Map<String, dynamic> credentials) async {
   Response? response =
        await apiPostRequests("request/change-drop-location", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> ratings(
      Map<String, dynamic> credentials) async {
    Response? response =
        await apiPostRequests("request/rating", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future <Response?> estimatedCost(
      Map<String, dynamic> credentials) async {
    Response? response =
        await apiPostRequests("request/estimated-ride-costs", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> addCard(Map<String, String> credentials) async {
    Response? response = await apiPostRequests("payment/stripe/add/card", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
}
