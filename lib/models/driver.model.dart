import 'dart:convert';

import 'package:flutter/foundation.dart';

class AvailableDrivers {
  final List<DriversInformations>? driversInformations;

  AvailableDrivers({this.driversInformations});

  Map<dynamic, dynamic> toMap() {
    return {
      'driversInformations':
          driversInformations?.map((x) => x.toMap()).toList(),
    };
  }

  factory AvailableDrivers.fromMap({required Map<dynamic, dynamic> map}) {
    final List<DriversInformations> driversInformations = [];
    map.keys.map((key) {
      driversInformations.add(DriversInformations.fromMap(map[key]));
    }).toList();

    return AvailableDrivers(
      driversInformations:
          driversInformations.isNotEmpty ? driversInformations : [],
    );
  }

  @override
  String toString() =>
      'AvailableDrivers(driversInformations: $driversInformations)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AvailableDrivers &&
        listEquals(other.driversInformations, driversInformations);
  }

  @override
  int get hashCode => driversInformations.hashCode;
}

class DriversInformations {
  final int? id;
  final int? isActive;
  final int? isAvailable;
  final List<String>? location;
  final String? status;
  final String? token;
  final String? mobile;
  final String? name;
  final String? updatedAt;
  final String? vehicleNumber;
  final String? vehicleType;
  final String? vehicleTypeName;

  DriversInformations({
    this.id,
    this.isActive,
    this.isAvailable,
    this.location,
    this.mobile,
    this.status,
    this.token,
    this.name,
    this.updatedAt,
    this.vehicleNumber,
    this.vehicleType,
    this.vehicleTypeName,
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'id': id,
      'isActive': isActive,
      'isAvailable': isAvailable,
      'location': location,
      'mobile': mobile,
      'name': name,
      'status': status,
      'token': token,
      'updatedAt': updatedAt,
      'vehicleNumber': vehicleNumber,
      'vehicleType': vehicleType,
      'vehicleTypeName': vehicleTypeName,
    };
  }

  factory DriversInformations.fromMap(Map<dynamic, dynamic> map) {
    return DriversInformations(
      id: map['id']?.toInt(),
      isActive: map['isActive']?.toInt(),
      isAvailable: map['isAvailable']?.toInt(),
      location:
          map['location'] != null ? List<String>.from(map['location']) : [],
      mobile: map['mobile'],
      name: map['name'],
      status: map['status'],
      token: map['token'],
      updatedAt: map['updatedAt'],
      vehicleNumber: map['vehicleNumber'],
      vehicleType: map['vehicleType'],
      vehicleTypeName: map['vehicleTypeName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriversInformations.fromJson(String source) =>
      DriversInformations.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DriversInformations(id: $id, isActive: $isActive, isAvailable: $isAvailable, location: $location, mobile: $mobile, status: $status, token:$token, name: $name, updatedAt: $updatedAt, vehicleNumber: $vehicleNumber, vehicleType: $vehicleType, vehicleTypeName: $vehicleTypeName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DriversInformations &&
        other.id == id &&
        other.isActive == isActive &&
        other.isAvailable == isAvailable &&
        other.location == location &&
        other.mobile == mobile &&
        other.name == name &&
        other.status == status &&
        other.token == token &&
        other.updatedAt == updatedAt &&
        other.vehicleNumber == vehicleNumber &&
        other.vehicleType == vehicleType &&
        other.vehicleTypeName == vehicleTypeName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isActive.hashCode ^
        isAvailable.hashCode ^
        location.hashCode ^
        mobile.hashCode ^
        name.hashCode ^
        status.hashCode ^
        token.hashCode ^
        updatedAt.hashCode ^
        vehicleNumber.hashCode ^
        vehicleType.hashCode ^
        vehicleTypeName.hashCode;
  }
}