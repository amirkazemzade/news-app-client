class CreateNewsResponseModel {
  CreateNewsResponseModel({
    String? state,
    dynamic message,
    CreatedNewsModel? result,
  }) {
    _state = state;
    _message = message;
    _result = result;
  }

  CreateNewsResponseModel.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    _result = json['result'] != null
        ? CreatedNewsModel.fromJson(json['result'])
        : null;
  }

  String? _state;
  dynamic _message;
  CreatedNewsModel? _result;

  String? get state => _state;

  dynamic get message => _message;

  CreatedNewsModel? get result => _result;

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

class CreatedNewsModel {
  CreatedNewsModel({
    String? type,
    int? id,
    String? title,
    String? body,
    int? categoryId,
    int? viewCount,
  }) {
    _type = type;
    _id = id;
    _title = title;
    _body = body;
    _categoryId = categoryId;
    _viewCount = viewCount;
  }

  CreatedNewsModel.fromJson(dynamic json) {
    _type = json['type'];
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
    _categoryId = json['category_id'];
    _viewCount = json['view_count'];
  }

  String? _type;
  int? _id;
  String? _title;
  String? _body;
  int? _categoryId;
  int? _viewCount;

  String? get type => _type;

  int? get id => _id;

  String? get title => _title;

  String? get body => _body;

  int? get categoryId => _categoryId;

  int? get viewCount => _viewCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    map['category_id'] = _categoryId;
    map['view_count'] = _viewCount;
    return map;
  }
}
