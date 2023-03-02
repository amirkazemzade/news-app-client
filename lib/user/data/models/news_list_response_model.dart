class NewsListResponseModel {
  NewsListResponseModel({
    String? state,
    dynamic message,
    NewsListModel? result,
  }) {
    _state = state;
    _message = message;
    _result = result;
  }

  NewsListResponseModel.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    _result = json['result'] != null
        ? NewsListModel.fromJson(json['result'])
        : null;
  }

  String? _state;
  dynamic _message;
  NewsListModel? _result;

  String? get state => _state;

  dynamic get message => _message;

  NewsListModel? get result => _result;

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

class NewsListModel {
  NewsListModel({
    String? type,
    List<NewsItemModel>? items,
  }) {
    _type = type;
    _items = items;
  }

  NewsListModel.fromJson(dynamic json) {
    _type = json['type'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(NewsItemModel.fromJson(v));
      });
    }
  }

  String? _type;
  List<NewsItemModel>? _items;

  String? get type => _type;

  List<NewsItemModel>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class NewsItemModel {
  NewsItemModel({
    String? type,
    int? id,
    String? title,
    int? categoryId,
    int? viewCount,
  }) {
    _type = type;
    _id = id;
    _title = title;
    _categoryId = categoryId;
    _viewCount = viewCount;
  }

  NewsItemModel.fromJson(dynamic json) {
    _type = json['type'];
    _id = json['id'];
    _title = json['title'];
    _categoryId = json['category_id'];
    _viewCount = json['view_count'];
  }

  String? _type;
  int? _id;
  String? _title;
  int? _categoryId;
  int? _viewCount;

  String? get type => _type;

  int? get id => _id;

  String? get title => _title;

  int? get categoryId => _categoryId;

  int? get viewCount => _viewCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['id'] = _id;
    map['title'] = _title;
    map['category_id'] = _categoryId;
    map['view_count'] = _viewCount;
    return map;
  }
}
