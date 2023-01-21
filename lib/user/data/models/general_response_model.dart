class GeneralResponseModel {
  GeneralResponseModel({
      String? state, 
      String? message, 
      dynamic result,}){
    _state = state;
    _message = message;
    _result = result;
}

  GeneralResponseModel.fromJson(dynamic json) {
    _state = json['state'];
    _message = json['message'];
    _result = json['result'];
  }
  String? _state;
  String? _message;
  dynamic _result;

  String? get state => _state;
  String? get message => _message;
  dynamic get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state'] = _state;
    map['message'] = _message;
    map['result'] = _result;
    return map;
  }

}