//

import 'dart:convert';



class StaduimModel {
  String? name;
  String? image;
  String? address;
  int? pricePerHour;
  double? longitude;
  double? latitude;
  bool? isAvailable;
  int? id;

  StaduimModel({
    this.name,
    this.image,
    this.address,
    this.pricePerHour,
    this.longitude,
    this.latitude,
    this.isAvailable,
    this.id,
  });

  factory StaduimModel.fromJson(Map<String, dynamic> json) => StaduimModel(
    name: json["name"],
    image: json["image"],
    address: json["address"],
    pricePerHour: json["pricePerHour"],
    longitude: json["longitude"].toDouble(),
    latitude: json["latitude"].toDouble(),
    isAvailable: json["isAvailable"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "address": address,
    "pricePerHour": pricePerHour,
    "longitude": longitude,
    "latitude": latitude,
    "isAvailable": isAvailable,
    "id": id,
  };
}
