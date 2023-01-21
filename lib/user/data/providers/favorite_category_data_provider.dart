import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app_client/user/data/models/favorite_categories_response_model.dart';
import 'package:news_app_client/user/data/models/general_response_model.dart';
import 'package:news_app_client/user/data/providers/hive_provider.dart';
import 'package:news_app_client/util/simple_dio_exception.dart';
import 'package:news_app_client/util/strings.dart';

class FavoriteCategoryDataProvider {
  FavoriteCategoryDataProvider._();

  static final FavoriteCategoryDataProvider _instance =
      FavoriteCategoryDataProvider._();

  factory FavoriteCategoryDataProvider() => _instance;

  final _dio = Dio();

  final _storage = HiveProvider();

  Future<FavoriteCategoriesResponseModel> fetchFavoriteCategories() async {
    late FavoriteCategoriesResponseModel data;
    try {
      Response response = await _dio.get(
        '$baseUrl/fav-cat',
        options: Options(
          headers: {
            authorizationText: 'Bearer ${await _storage.readAccessToken()}'
          },
        ),
      );
      if (response.statusCode == 200) {
        data = FavoriteCategoriesResponseModel.fromJson(response.data);
      }
      return data;
    } on DioError catch (e) {
      throw SimpleDioException(dioError: e);
    }
  }

  Future<GeneralResponseModel> updateFavoriteCategories(
      List<int> categories) async {
    late GeneralResponseModel data;
    try {
      Response response = await _dio.patch(
        '$baseUrl/fav-cat',
        options: Options(
          headers: {
            authorizationText: 'Bearer ${await _storage.readAccessToken()}'
          },
        ),
        data: jsonEncode({
          'categories': categories,
        }),
      );
      if (response.statusCode == 200) {
        data = GeneralResponseModel.fromJson(response.data);
      }
      return data;
    } on DioError catch (e) {
      throw SimpleDioException(dioError: e);
    }
  }
}
