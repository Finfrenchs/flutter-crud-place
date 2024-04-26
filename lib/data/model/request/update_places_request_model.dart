import 'dart:convert';

class UpdatePlacesRequestModel {
  final String? name;
  final String? address;
  final String? coordinates;
  final String? description;

  UpdatePlacesRequestModel({
    this.name,
    this.address,
    this.coordinates,
    this.description,
  });

  factory UpdatePlacesRequestModel.fromJson(String str) =>
      UpdatePlacesRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdatePlacesRequestModel.fromMap(Map<String, dynamic> json) =>
      UpdatePlacesRequestModel(
        name: json["name"],
        address: json["address"],
        coordinates: json["coordinates"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "address": address,
        "coordinates": coordinates,
        "description": description,
      };
}
