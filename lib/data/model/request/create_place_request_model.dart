// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class CreatePlaceRequestModel {
  final String name;
  final String address;
  final String coordinates;
  final String description;
  final XFile? image;
  CreatePlaceRequestModel({
    required this.name,
    required this.address,
    required this.coordinates,
    required this.description,
    this.image,
  });

  Map<String, String> toMap() {
    return <String, String>{
      'name': name,
      'address': address,
      'coordinates': coordinates,
      'description': description,
      //'image': image.toMap(),
    };
  }

  factory CreatePlaceRequestModel.fromMap(Map<String, dynamic> map) {
    return CreatePlaceRequestModel(
      name: map['name'] as String,
      address: map['address'] as String,
      coordinates: map['coordinates'] as String,
      description: map['description'] as String,
      //image: XFile.fromMap(map['image'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePlaceRequestModel.fromJson(String source) =>
      CreatePlaceRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
