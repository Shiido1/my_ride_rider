import 'package:flutter/material.dart';
import 'package:my_ride/repository/auth_repo.dart';

import '../../../models/auth_model.dart';
import '../../../utils/Flushbar_mixin.dart';

class ScheduleProvider extends ChangeNotifier with FlushBarMixin {
  final AuthRepo authRepo = AuthRepo();
  final AuthModel model = AuthModel();

  Map<String, dynamic>? get upcomingResponse => _upcomingResponse;
  Map<String, dynamic>? get completedResponse => _completedResponse;
  Map<String, dynamic>? get cancelledResponse => _cancelledResponse;
  Map<String, dynamic>? _cancelledResponse;
  Map<String, dynamic>? _completedResponse;
  Map<String, dynamic>? _upcomingResponse;

  Future<void> getUpcomingTrip(context) async {
    model.isGetUpcomingLoading = true;

    try {
      Map<String, dynamic>? response = await authRepo.getUpcomingTrips();
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        model.isGetUpcomingLoading = false;
        _upcomingResponse = response;
        notifyListeners();
      } else {
        showErrorNotification(context, response!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
    model.isGetUpcomingLoading = false;
    notifyListeners();
  }

  Future<void> getCompletedTrips({context}) async {
    try {
      model.isGetCompletedLoading = true;
      // notifyListeners();
      Map<String, dynamic>? response = await authRepo.getCompletedTrips();
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        model.isGetCompletedLoading = false;
        _completedResponse = response;
        notifyListeners();
      } else {
        showErrorNotification(context, response!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }
    model.isGetCompletedLoading = false;
    notifyListeners();
  }

  Future<void> getCancelledTrip({context}) async {
    try {
      model.isGetCancelledLoading = true;
      notifyListeners();
      Map<String, dynamic>? response = await authRepo.getCancelledTrips();
      debugPrint("RESPONSE: $response");
      if (response != null && response.isNotEmpty) {
        model.isGetCancelledLoading = false;
        _cancelledResponse = response;
        notifyListeners();
      } else {
        showErrorNotification(context, response!["message"]);
      }
    } catch (e, str) {
      debugPrint("Error: $e");
      debugPrint("StackTrace: $str");
    }

    model.isGetCancelledLoading = false;
    notifyListeners();
  }
}
