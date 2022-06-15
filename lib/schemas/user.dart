class User {
  String? tokenType = "";
  int? expiresIn = 0;
  String? refreshToken = "";
  String? firstName = "";
  String? lastName = "";
  String? emailAdd = "";
  String? phoneNum = "";
  String? typeOfDevice = "";
  String? deviceTkn = "";
  String? userID = "";
  bool? isVerified;
  bool? isActive;
  bool? isRider;
  bool? isDriver;
  int? role;
  double? rating;
  bool? isAvailable;
  String? name;
  String? id;
  String? pickUpLocation;
  String? dropLocation;


  User({this.tokenType, this.expiresIn, this.refreshToken, this.userID,
  this.firstName, this.lastName, this.emailAdd, this.phoneNum, this.typeOfDevice, this.deviceTkn, this.isVerified,
    this.isActive, this.isRider, this.isDriver, this.role, this.rating, this.isAvailable, this.name, this.id,
  this.dropLocation, this.pickUpLocation});

    User.fromJson(Map<String, dynamic> json) {
    tokenType = json["token_type"];
    expiresIn = json["expires_in"];
    refreshToken = json["refresh_token"];
    firstName = json["name"];
    lastName = json["last_name"];
    emailAdd = json["email"];
    phoneNum = json["mobile"];
    typeOfDevice = json["login_by"];
    deviceTkn = json["device_token"];
    id = json["_id"];
    isVerified = json['isVerified'];
    isActive = json['isActive'];
    isRider = json['isRider'];
    isDriver = json['isDriver'];
    rating = double.parse(json['rating'].toString());
    role = json['role'];
    isAvailable = json['isAvailable'];
    pickUpLocation = json['pickUpLocation'];
    dropLocation = json['dropLocation'];

  }

}
