import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app_client/data/models/auth_response_model.dart';
import 'package:news_app_client/util/simple_dio_exception.dart';
import 'package:news_app_client/util/strings.dart';

class UserDataProvider {
  UserDataProvider._();

  static final UserDataProvider _instance = UserDataProvider._();

  factory UserDataProvider() => _instance;

  final _dio = Dio();

  Future<AuthResponseModel> login(String username, String password) async {
    late AuthResponseModel data;
    try {
      Response response = await _dio.post(
        '$baseUrl/login',
        data: jsonEncode({
          "username": username,
          "password": password,
        }),
      );
      if (response.statusCode == 200) {
        data = AuthResponseModel.fromJson(response.data);
      }
      return data;
    } on DioError catch (e) {
      throw SimpleDioException(dioError: e, handleTokenInvalid: false);
    }
  }

  Future<AuthResponseModel> signUp(String username, String password) async {
    late AuthResponseModel data;
    try {
      Response response = await _dio.post(
        '$baseUrl/sign-up',
        data: jsonEncode({
          "username": username,
          "password": password,
        }),
      );
      if (response.statusCode == 200) {
        data = AuthResponseModel.fromJson(response.data);
      }
      return data;
    } on DioError catch (e) {
      throw SimpleDioException(dioError: e, handleTokenInvalid: false);
    }
  }
}
