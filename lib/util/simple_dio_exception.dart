import 'package:dio/dio.dart';
import 'package:news_app_client/user/data/models/general_response_model.dart';
import 'package:news_app_client/util/strings.dart';
import 'package:restart_app/restart_app.dart';

class SimpleDioException implements Exception {
  late final String message;
  final DioError? dioError;
  final bool handleTokenInvalid;

  SimpleDioException({
    required this.dioError,
    this.handleTokenInvalid = true,
  }) {
    message = _handleDioError();
  }

  SimpleDioException.message({
    required this.message,
    required this.handleTokenInvalid,
  }) : dioError = null;

  String _handleDioError() {
    assert(dioError != null);
    if (dioError!.type == DioErrorType.cancel) return cancelDioError;
    if (dioError!.type == DioErrorType.connectTimeout) return timeoutError;
    if (dioError!.type == DioErrorType.receiveTimeout) return timeoutError;
    if (dioError!.type == DioErrorType.sendTimeout) return timeoutError;
    if (dioError!.type == DioErrorType.response) {
      if (dioError!.response!.statusCode == 401) {
        if (handleTokenInvalid) Restart.restartApp();
        return tokenIsInvalidError;
      }
      if (dioError!.response!.data == null) return defaultErrorMessage;
      try {
        return GeneralResponseModel.fromJson(dioError!.response!.data)
                .message ??
            defaultErrorMessage;
      } catch (_) {
        return defaultErrorMessage;
      }
    }
    if (dioError!.type == DioErrorType.other) {
      return dioError!.message.contains("SocketException")
          ? internetConnectionError
          : defaultErrorMessage;
    }
    return defaultErrorMessage;
  }

  @override
  String toString() => message;
}
