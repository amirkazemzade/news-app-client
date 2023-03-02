import 'package:dio/dio.dart';
import 'package:news_app_client/user/data/models/news_details_response_model.dart';
import 'package:news_app_client/user/data/models/news_list_response_model.dart';
import 'package:news_app_client/user/data/providers/hive_provider.dart';
import 'package:news_app_client/util/simple_dio_exception.dart';
import 'package:news_app_client/util/strings.dart';

class NewsDataProvider {
  NewsDataProvider._();

  static final NewsDataProvider _instance = NewsDataProvider._();

  factory NewsDataProvider() => _instance;

  final _dio = Dio();

  final _storage = HiveProvider();

  Future<NewsListResponseModel> fetchUserNewsFeed() async {
    late NewsListResponseModel data;
    try {
      Response response = await _dio.get(
        '$baseUrl/news',
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
        '$baseUrl/news/$newsId',
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
}
