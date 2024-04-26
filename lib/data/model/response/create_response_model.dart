import 'dart:convert';

class CreatePlacesResponseModel {
  final bool? success;
  final String? message;
  final Data? data;

  CreatePlacesResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory CreatePlacesResponseModel.fromJson(String str) =>
      CreatePlacesResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreatePlacesResponseModel.fromMap(Map<String, dynamic> json) =>
      CreatePlacesResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  final String? name;
  final String? address;
  final String? coordinates;
  final String? description;
  final String? image;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Data({
    this.name,
    this.address,
    this.coordinates,
    this.description,
    this.image,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        name: json["name"],
        address: json["address"],
        coordinates: json["coordinates"],
        description: json["description"],
        image: json["image"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "address": address,
        "coordinates": coordinates,
        "description": description,
        "image": image,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
