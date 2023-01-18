import 'package:news_app_client/data/models/auth_response_model.dart';
import 'package:news_app_client/data/providers/user_data_provider.dart';

class Repository {
  Repository._();

  static final Repository _instance = Repository._();

  factory Repository() => _instance;

  /* Providers */
  final _userProvider = UserDataProvider();

  /* User */
  Future<AuthResponseModel> login(String username, String password) async =>
      _userProvider.login(username, password);

  Future<AuthResponseModel> signUp(String username, String password) async =>
      _userProvider.signUp(username, password);
}
