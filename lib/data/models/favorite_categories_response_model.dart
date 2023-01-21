class FavoriteCategoriesResponseModel {
  FavoriteCategoriesResponseModel({
      String? state, 
      dynamic message, 
      FavoriteCategoriesModel? result,}){
    _state = state;
    _message = message;
    _result = result;
}

  FavoriteCategoriesResponseModel.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    _result = json['result'] != null ? FavoriteCategoriesModel.fromJson(json['result']) : null;
  }
  String? _state;
  dynamic _message;
  FavoriteCategoriesModel? _result;

  String? get state => _state;
  dynamic get message => _message;
  FavoriteCategoriesModel? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

class FavoriteCategoriesModel {
  FavoriteCategoriesModel({
      String? type, 
      List<int>? categories,}){
    _type = type;
    _categories = categories;
}

  FavoriteCategoriesModel.fromJson(dynamic json) {
    _type = json['type'];
    _categories = json['categories'] != null ? json['categories'].cast<int>() : [];
  }
  String? _type;
  List<int>? _categories;

  String? get type => _type;
  List<int>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['categories'] = _categories;
    return map;
  }

}