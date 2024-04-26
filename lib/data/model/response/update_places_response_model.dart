import 'dart:convert';

class UpdatePlacesResponseModel {
  final String? message;
  final Data? data;

  UpdatePlacesResponseModel({
    this.message,
    this.data,
  });

  factory UpdatePlacesResponseModel.fromJson(String str) =>
      UpdatePlacesResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdatePlacesResponseModel.fromMap(Map<String, dynamic> json) =>
      UpdatePlacesResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  final int? id;
  final String? name;
  final String? address;
  final String? coordinates;
  final String? description;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.name,
    this.address,
    this.coordinates,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        coordinates: json["coordinates"],
        description: json["description"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "coordinates": coordinates,
        "description": description,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
