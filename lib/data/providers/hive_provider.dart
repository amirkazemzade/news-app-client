import 'package:hive/hive.dart';
import 'package:news_app_client/util/strings.dart';

class HiveProvider {
  HiveProvider._();

  static final HiveProvider _instance = HiveProvider._();

  factory HiveProvider() => _instance;

  final _collection = BoxCollection.open(
    'archive-storage',
    {accessTokenKey},
    key: HiveAesCipher(Hive.generateSecureKey()),
  );

  Future<CollectionBox<String>> _getCollectionBox() async {
    final collection = await _collection;
    return collection.openBox<String>(accessTokenKey);
  }

  Future<void> writeAccessToken(String accessToken) async {
    final box = await _getCollectionBox();
    await box.put(accessTokenKey, accessToken);
  }

  Future<String?> readAccessToken() async {
    final box = await _getCollectionBox();
    return box.get(accessTokenKey);
  }

  Future<void> deleteAccessToken() async {
    final box = await _getCollectionBox();
    await box.delete(accessTokenKey);
  }
}
