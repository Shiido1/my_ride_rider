import 'package:my_ride/utils/services.dart';

class TripRepo with Services {
  Future<bool> getActiveDriver(Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response = await apiPostRequests("request/create", credentials);

    if (response != null) {
      return true;
    }

    return false;
  }

  Future<bool> getAvailableRide(Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response =
        await apiPostRequests("trips/trip-session", credentials);

    if (response != null) {
      return true;
    }

    return false;
  }

  Future<bool> getActiveRide(Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response =
    await apiPostRequests("trips/trip-session", credentials);

    if (response != null) {
      return true;
    }

    return false;
  }

  Future<bool> requestRide(Map<String, String> sessionId) async {
    Map<String, dynamic>? response =
    await apiPostRequests("request/create", sessionId);

    if (response != null) {
      return true;
    }

    return false;
  }

  Future<bool> createRideRequest(Map<String, String> sessionId) async {
    Map<String, dynamic>? response =
        await apiPostRequests("request/create", sessionId);

    if (response != null) {
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>?> phoneVerification(
      Map<String, String> credentials) async {
    Map<String, dynamic>? response =
        await apiPostRequests("auth/verify-number", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> otpVerification(
      Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response =
        await apiPostRequests("auth/verify-otp-token", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }
}
