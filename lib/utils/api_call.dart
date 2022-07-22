import 'package:dio/dio.dart';
import 'package:my_ride/models/global_model.dart';

Dio dio = Dio();
makeNetworkCall({String? origin, String? destination}) async {
  Response response = await dio.get(
      "https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origin&destinations=$destination&mode=car&key=$googleApikey");
  return response.data;
}
