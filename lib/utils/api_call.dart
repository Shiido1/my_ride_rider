import 'package:dio/dio.dart';
import 'package:my_ride/models/global_model.dart';

Dio dio = Dio();
makeNetworkCall({String? origin, String? destination}) async {
  print('nill1 resse $origin and $destination');
  Response response = await dio.get(
      "https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origin&destinations=$destination&mode=car&key=$googleApikey");
      print('nill response ${response.data}');
  return response.data;
}
