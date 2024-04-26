import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_place_app/data/datasource/auth_local_datasource.dart';
import 'package:flutter_place_app/data/model/request/create_place_request_model.dart';
import 'package:flutter_place_app/data/model/request/update_places_request_model.dart';
import 'package:flutter_place_app/data/model/response/create_response_model.dart';
import 'package:flutter_place_app/data/model/response/get_places_response_model.dart';
import 'package:flutter_place_app/data/model/response/update_places_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';

class PlacesRemoteDatasource {
  Future<Either<String, GetPlacesResponseModel>> getPlaces() async {
    final authData = await AuthLocalDataSource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData!.token}'
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/api-places'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(GetPlacesResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, String>> deletePlace(int id) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData!.token}'
    };
    final response = await http.delete(
      Uri.parse('${Variables.baseUrl}/api/api-places/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(response.body);
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, UpdatePlacesResponseModel>> updatePlaces(
      UpdatePlacesRequestModel requestModel, int id) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData!.token}',
      'Content-Type': 'application/json'
    };

    final response = await http.put(
      Uri.parse('${Variables.baseUrl}/api/api-places/$id'),
      headers: headers,
      body: requestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(UpdatePlacesResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, CreatePlacesResponseModel>> addPlace(
      CreatePlaceRequestModel requestModel) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData!.token}'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Variables.baseUrl}/api/api-places'),
    );

    request.fields.addAll(requestModel.toMap());
    request.files.add(
        await http.MultipartFile.fromPath('image', requestModel.image!.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return right(CreatePlacesResponseModel.fromJson(body));
    } else {
      return left(body);
    }
  }
}
