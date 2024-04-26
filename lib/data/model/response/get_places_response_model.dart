import 'dart:convert';

class GetPlacesResponseModel {
  final List<Places>? data;
  final String? message;
  final String? status;

  GetPlacesResponseModel({
    this.data,
    this.message,
    this.status,
  });

  factory GetPlacesResponseModel.fromJson(String str) =>
      GetPlacesResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPlacesResponseModel.fromMap(Map<String, dynamic> json) =>
      GetPlacesResponseModel(
        data: json["data"] == null
            ? []
            : List<Places>.from(json["data"]!.map((x) => Places.fromMap(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
        "status": status,
      };
}

class Places {
  final int? id;
  final String? name;
  final String? address;
  final String? coordinates;
  final String? description;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Places({
    this.id,
    this.name,
    this.address,
    this.coordinates,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Places.fromJson(String str) => Places.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Places.fromMap(Map<String, dynamic> json) => Places(
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
