class AuthResponseModel {
  AuthResponseModel({
      String? state, 
      Result? result,}){
    _state = state;
    _result = result;
}

  AuthResponseModel.fromJson(dynamic json) {
    _state = json['state'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _state;
  Result? _result;

  String? get state => _state;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

class Result {
  Result({
      String? type, 
      String? token,}){
    _type = type;
    _token = token;
  }

  Result.fromJson(dynamic json) {
    _type = json['type'];
    _token = json['token'];
    _role = json['role'];
  }

  String? _type;
  String? _token;
  String? _role;

  String? get type => _type;

  String? get token => _token;

  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['token'] = _token;
    map['role'] = _role;
    return map;
  }

}