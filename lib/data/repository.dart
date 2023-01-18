import 'package:news_app_client/data/models/auth_response_model.dart';
import 'package:news_app_client/data/models/news_details_response_model.dart';
import 'package:news_app_client/data/models/user_news_response_model.dart';
import 'package:news_app_client/data/providers/news_data_provider.dart';
import 'package:news_app_client/data/providers/user_data_provider.dart';

class Repository {
  Repository._();

  static final Repository _instance = Repository._();

  factory Repository() => _instance;

  /* Providers */
  final _userProvider = UserDataProvider();
  final _newsProvider = NewsDataProvider();

  /* User */
  Future<AuthResponseModel> login(String username, String password) async =>
      _userProvider.login(username, password);

  Future<AuthResponseModel> signUp(String username, String password) async =>
      _userProvider.signUp(username, password);

  /* News */
  Future<UserNewsResponseModel> fetchUserNewsFeed() async =>
      _newsProvider.fetchUserNewsFeed();

  Future<NewsDetailsResponseModel> fetchNewsDetails(int newsId) async =>
      _newsProvider.fetchNewsDetails(newsId);
}
