import 'package:dartz/dartz.dart';
import 'package:flutter_place_app/data/model/request/register_request_model.dart';
import 'package:flutter_place_app/data/model/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../model/request/login_request_model.dart';
import '../model/response/logout_response_model.dart';
import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url,
      body: requestModel.toJson(),
      headers: headers,
    );

    if (response.statusCode == 200) {
      await AuthLocalDataSource()
          .saveAuthData(AuthResponseModel.fromJson(response.body));
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal login');
    }
  }

  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final url = Uri.parse('${Variables.baseUrl}/api/register');
    final response = await http.post(
      url,
      body: requestModel.toJson(),
      headers: headers,
    );

    if (response.statusCode == 201) {
      await AuthLocalDataSource()
          .saveAuthData(AuthResponseModel.fromJson(response.body));
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal register');
    }
  }

  Future<Either<String, LogoutResponseModel>> logout() async {
    final authDataModel = await AuthLocalDataSource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authDataModel?.token}',
    };
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      await AuthLocalDataSource().removeAuthData();
      return Right(LogoutResponseModel.fromJson(response.body));
    } else {
      return const Left('Logout gagal');
    }
  }
}
