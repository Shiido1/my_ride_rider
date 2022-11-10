class UpcomingTrip {
  String? id;
  String? requestNumber;
  dynamic rideOtp;
  int? isLater;
  int? userId;
  String? serviceLocationId;
  String? tripStartTime;
  int? tripStartTimestamp;
  dynamic arrivedAt;
  dynamic acceptedAt;
  dynamic completedAt;
  int? isDriverStarted;
  int? isDriverArrived;
  String? updatedAt;
  int? isTripStart;
  String? totalDistance;
  int? totalTime;
  int? isCompleted;
  int? isCancelled;
  String? cancelMethod;
  String? paymentOpt;
  int? isPaid;
  int? userRated;
  int? driverRated;
  String? unit;
  String? zoneTypeId;
  String? vehicleTypeName;
  String? vehicleTypeImage;
  String? carMakeName;
  String? carModelName;
  double? pickLat;
  double? pickLng;
  double? dropLat;
  double? dropLng;
  String? pickAddress;
  String? dropAddress;
  String? requestedCurrencyCode;
  dynamic requestedCurrencySymbol;
  int? userCancellationFee;
  bool? isRental;
  dynamic rentalPackageId;
  int? isOutStation;
  String? rentalPackageName;
  bool? showDropLocation;
  bool? showOtpFeature;
  int? requestEtaAmount;
  String? paymentTypeString;
  String? cvTripStartTime;
  String? cvCompletedAt;
  List<dynamic>? driverDetail;
  UserDetail? userDetail;

  UpcomingTrip(
      {this.id,
      this.requestNumber,
      this.rideOtp,
      this.isLater,
      this.userId,
      this.serviceLocationId,
      this.tripStartTime,
      this.tripStartTimestamp,
      this.arrivedAt,
      this.acceptedAt,
      this.completedAt,
      this.isDriverStarted,
      this.isDriverArrived,
      this.updatedAt,
      this.isTripStart,
      this.totalDistance,
      this.totalTime,
      this.isCompleted,
      this.isCancelled,
      this.cancelMethod,
      this.paymentOpt,
      this.isPaid,
      this.userRated,
      this.driverRated,
      this.unit,
      this.zoneTypeId,
      this.vehicleTypeName,
      this.vehicleTypeImage,
      this.carMakeName,
      this.carModelName,
      this.pickLat,
      this.pickLng,
      this.dropLat,
      this.dropLng,
      this.pickAddress,
      this.dropAddress,
      this.requestedCurrencyCode,
      this.requestedCurrencySymbol,
      this.userCancellationFee,
      this.isRental,
      this.rentalPackageId,
      this.isOutStation,
      this.rentalPackageName,
      this.showDropLocation,
      this.showOtpFeature,
      this.requestEtaAmount,
      this.paymentTypeString,
      this.cvTripStartTime,
      this.cvCompletedAt,
      this.driverDetail,
      this.userDetail});

  UpcomingTrip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestNumber = json['request_number'];
    rideOtp = json['ride_otp'];
    isLater = json['is_later'];
    userId = json['user_id'];
    serviceLocationId = json['service_location_id'];
    tripStartTime = json['trip_start_time'];
    tripStartTimestamp = json['trip_start_timestamp'];
    arrivedAt = json['arrived_at'];
    acceptedAt = json['accepted_at'];
    completedAt = json['completed_at'];
    isDriverStarted = json['is_driver_started'];
    isDriverArrived = json['is_driver_arrived'];
    updatedAt = json['updated_at'];
    isTripStart = json['is_trip_start'];
    totalDistance = json['total_distance'];
    totalTime = json['total_time'];
    isCompleted = json['is_completed'];
    isCancelled = json['is_cancelled'];
    cancelMethod = json['cancel_method'];
    paymentOpt = json['payment_opt'];
    isPaid = json['is_paid'];
    userRated = json['user_rated'];
    driverRated = json['driver_rated'];
    unit = json['unit'];
    zoneTypeId = json['zone_type_id'];
    vehicleTypeName = json['vehicle_type_name'];
    vehicleTypeImage = json['vehicle_type_image'];
    carMakeName = json['car_make_name'];
    carModelName = json['car_model_name'];
    pickLat = json['pick_lat'];
    pickLng = json['pick_lng'];
    dropLat = json['drop_lat'];
    dropLng = json['drop_lng'];
    pickAddress = json['pick_address'];
    dropAddress = json['drop_address'];
    requestedCurrencyCode = json['requested_currency_code'];
    requestedCurrencySymbol = json['requested_currency_symbol'];
    userCancellationFee = json['user_cancellation_fee'];
    isRental = json['is_rental'];
    rentalPackageId = json['rental_package_id'];
    isOutStation = json['is_out_station'];
    rentalPackageName = json['rental_package_name'];
    showDropLocation = json['show_drop_location'];
    showOtpFeature = json['show_otp_feature'];
    requestEtaAmount = json['request_eta_amount'];
    paymentTypeString = json['payment_type_string'];
    cvTripStartTime = json['cv_trip_start_time'];
    cvCompletedAt = json['cv_completed_at'];
    if (json['driverDetail'] != null) {
      driverDetail = <Null>[];
      json['driverDetail'].forEach((v) {
        driverDetail!.add((v));
      });
    }
    userDetail = json['userDetail'] != null
        ? UserDetail.fromJson(json['userDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['request_number'] = requestNumber;
    data['ride_otp'] = rideOtp;
    data['is_later'] = isLater;
    data['user_id'] = userId;
    data['service_location_id'] = serviceLocationId;
    data['trip_start_time'] = tripStartTime;
    data['trip_start_timestamp'] = tripStartTimestamp;
    data['arrived_at'] = arrivedAt;
    data['accepted_at'] = acceptedAt;
    data['completed_at'] = completedAt;
    data['is_driver_started'] = isDriverStarted;
    data['is_driver_arrived'] = isDriverArrived;
    data['updated_at'] = updatedAt;
    data['is_trip_start'] = isTripStart;
    data['total_distance'] = totalDistance;
    data['total_time'] = totalTime;
    data['is_completed'] = isCompleted;
    data['is_cancelled'] = isCancelled;
    data['cancel_method'] = cancelMethod;
    data['payment_opt'] = paymentOpt;
    data['is_paid'] = isPaid;
    data['user_rated'] = userRated;
    data['driver_rated'] = driverRated;
    data['unit'] = unit;
    data['zone_type_id'] = zoneTypeId;
    data['vehicle_type_name'] = vehicleTypeName;
    data['vehicle_type_image'] = vehicleTypeImage;
    data['car_make_name'] = carMakeName;
    data['car_model_name'] = carModelName;
    data['pick_lat'] = pickLat;
    data['pick_lng'] = pickLng;
    data['drop_lat'] = dropLat;
    data['drop_lng'] = dropLng;
    data['pick_address'] = pickAddress;
    data['drop_address'] = dropAddress;
    data['requested_currency_code'] = requestedCurrencyCode;
    data['requested_currency_symbol'] = requestedCurrencySymbol;
    data['user_cancellation_fee'] = userCancellationFee;
    data['is_rental'] = isRental;
    data['rental_package_id'] = rentalPackageId;
    data['is_out_station'] = isOutStation;
    data['rental_package_name'] = rentalPackageName;
    data['show_drop_location'] = showDropLocation;
    data['show_otp_feature'] = showOtpFeature;
    data['request_eta_amount'] = requestEtaAmount;
    data['payment_type_string'] = paymentTypeString;
    data['cv_trip_start_time'] = cvTripStartTime;
    data['cv_completed_at'] = cvCompletedAt;
    if (driverDetail != null) {
      data['driverDetail'] = driverDetail!.map((v) => v.toJson()).toList();
    }
    if (userDetail != null) {
      data['userDetail'] = userDetail!.toJson();
    }
    return data;
  }
}

class UserDetail {
  Data? data;

  UserDetail({this.data});

  UserDetail.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  dynamic lastName;
  dynamic username;
  String? email;
  String? mobile;
  String? profilePicture;
  int? active;
  int? emailConfirmed;
  int? mobileConfirmed;
  String? lastKnownIp;
  String? lastLoginAt;
  double? rating;
  int? noOfRatings;
  String? refferalCode;
  String? countryCode;
  String? currencyCode;
  String? currencySymbol;
  String? mapKey;
  bool? showRentalRide;
  String? referralComissionString;
  Sos? sos;

  Data(
      {this.id,
      this.name,
      this.lastName,
      this.username,
      this.email,
      this.mobile,
      this.profilePicture,
      this.active,
      this.emailConfirmed,
      this.mobileConfirmed,
      this.lastKnownIp,
      this.lastLoginAt,
      this.rating,
      this.noOfRatings,
      this.refferalCode,
      this.countryCode,
      this.currencyCode,
      this.currencySymbol,
      this.mapKey,
      this.showRentalRide,
      this.referralComissionString,
      this.sos});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    profilePicture = json['profile_picture'];
    active = json['active'];
    emailConfirmed = json['email_confirmed'];
    mobileConfirmed = json['mobile_confirmed'];
    lastKnownIp = json['last_known_ip'];
    lastLoginAt = json['last_login_at'];
    rating = json['rating'];
    noOfRatings = json['no_of_ratings'];
    refferalCode = json['refferal_code'];
    countryCode = json['country_code'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    mapKey = json['map_key'];
    showRentalRide = json['show_rental_ride'];
    referralComissionString = json['referral_comission_string'];
    sos = json['sos'] != null ? Sos.fromJson(json['sos']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['last_name'] = lastName;
    data['username'] = username;
    data['email'] = email;
    data['mobile'] = mobile;
    data['profile_picture'] = profilePicture;
    data['active'] = active;
    data['email_confirmed'] = emailConfirmed;
    data['mobile_confirmed'] = mobileConfirmed;
    data['last_known_ip'] = lastKnownIp;
    data['last_login_at'] = lastLoginAt;
    data['rating'] = rating;
    data['no_of_ratings'] = noOfRatings;
    data['refferal_code'] = refferalCode;
    data['country_code'] = countryCode;
    data['currency_code'] = currencyCode;
    data['currency_symbol'] = currencySymbol;
    data['map_key'] = mapKey;
    data['show_rental_ride'] = showRentalRide;
    data['referral_comission_string'] = referralComissionString;
    if (sos != null) {
      data['sos'] = sos!.toJson();
    }
    return data;
  }
}

class Sos {
  List<dynamic>? data;

  Sos({this.data});

  Sos.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {
        data!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v).toList();
    }
    return data;
  }
}
