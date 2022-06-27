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

  Future<Map<String, dynamic>?> login(Map<String, String> credentials) async {
    Map<String, dynamic>? response =
        await apiPostRequests("user/login", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> register(
      Map<String, String> credentials) async {
    Map<String, dynamic>? response =
        await apiPostRequests("user/register", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> phoneVerification(
      Map<String, String> credentials) async {
    Map<String, dynamic>? response =
        await apiPostRequests("user/register/send-otp", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> otpVerification(
      Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response =
        await apiPostRequests("user/register/validate-otp", credentials);

    if (response != null) {
      print(response);
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

  Future<Map<String, dynamic>?> profilePicture(
      Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response =
        await apiUploadPostRequests("user/update-profile-picture", credentials);

    if (response != null) {
      print(response);
      return response;
    }

    return null;
  }
}
