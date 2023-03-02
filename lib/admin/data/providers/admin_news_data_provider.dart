import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app_client/admin/data/models/create_news_response_model.dart';
import 'package:news_app_client/user/data/models/general_response_model.dart';
import 'package:news_app_client/user/data/models/news_details_response_model.dart';
import 'package:news_app_client/user/data/models/news_list_response_model.dart';
import 'package:news_app_client/user/data/providers/hive_provider.dart';
import 'package:news_app_client/util/simple_dio_exception.dart';
import 'package:news_app_client/util/strings.dart';

class AdminNewsDataProvider {
  AdminNewsDataProvider._();

  static final AdminNewsDataProvider _instance = AdminNewsDataProvider._();

  factory AdminNewsDataProvider() => _instance;

  final _dio = Dio();

  final _storage = HiveProvider();

  Future<NewsListResponseModel> fetchNews() async {
    late NewsListResponseModel data;
    try {
      Response response = await _dio.get(
        '$baseUrl/admin/news',
        options: Options(
          headers: {
            authorizationText: 'Bearer ${await _storage.readAccessToken()}'
          },
        ),
      );
      if (response.statusCode == 200) {
        data = NewsListResponseModel.fromJson(response.data);
      }
      return data;
    } on DioError catch (e) {
      throw SimpleDioException(dioError: e);
    }
  }

  Future<NewsDetailsResponseModel> fetchNewsDetails(int newsId) async {
    late NewsDetailsResponseModel data;
    try {
      Response response = await _dio.get(
        '$baseUrl/admin/news/$newsId',
        options: Options(
          headers: {
            authorizationText: 'Bearer ${await _storage.readAccessToken()}'
          },
        ),
      );
      if (response.statusCode == 200) {
        data = NewsDetailsResponseModel.fromJson(response.data);
      }
      return data;
    } on DioError catch (e) {
      throw SimpleDioException(dioError: e);
    }
  }

  Future<CreateNewsResponseModel> createNews(
    String title,
    String body,
    int categoryId,
    int viewCount,
  ) async {
    late CreateNewsResponseModel data;
    try {
      Response response = await _dio.post(
        '$baseUrl/admin/news',
        options: Options(
          headers: {
            authorizationText: 'Bearer ${await _storage.readAccessToken()}'
          },
        ),
        data: jsonEncode({
          'title': title,
          'body': body,
          'category_id': categoryId,
          'view_count': viewCount,
        }),
      );
      if (response.statusCode == 200) {
        data = CreateNewsResponseModel.fromJson(response.data);
      }
      return data;
    } on DioError catch (e) {
      throw SimpleDioException(dioError: e);
    }
  }

  Future<GeneralResponseModel> updateNews(
    int newsId,
    String? title,
    String? body,
    int? categoryId,
    int? viewCount,
  ) async {
    late GeneralResponseModel data;
    try {
      final parameters = {};
      if (title != null) {
        parameters['title'] = title;
      }
      if (body != null) {
        parameters['body'] = body;
      }
      if (categoryId != null) {
        parameters['category_id'] = categoryId;
      }
      if (viewCount != null) {
        parameters['view_count'] = viewCount;
      }
      Response response = await _dio.patch(
        '$baseUrl/admin/news/$newsId',
        options: Options(
          headers: {
            authorizationText: 'Bearer ${await _storage.readAccessToken()}'
          },
        ),
        data: jsonEncode(parameters),
      );
      if (response.statusCode == 200) {
        data = GeneralResponseModel.fromJson(response.data);
      }
      return data;
    } on DioError catch (e) {
      throw SimpleDioException(dioError: e);
    }
  }

  Future<GeneralResponseModel> deleteNews(int newsId) async {
    late GeneralResponseModel data;
    try {
      Response response = await _dio.delete(
        '$baseUrl/admin/news/$newsId',
        options: Options(
          headers: {
            authorizationText: 'Bearer ${await _storage.readAccessToken()}'
          },
        ),
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
