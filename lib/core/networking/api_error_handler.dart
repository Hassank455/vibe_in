import 'package:dio/dio.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(data: "Connection to server failed");
        case DioExceptionType.cancel:
          return ApiErrorModel(data: "Request to the server was cancelled");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(data: "Connection timeout with the server");
        case DioExceptionType.unknown:
          return ApiErrorModel(
              data:
                  "Connection to the server failed due to internet connection");
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
              data: "Receive timeout in connection with the server");
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
              data: "Send timeout in connection with the server");
        default:
          return ApiErrorModel(data: "Something went wrong");
      }
    } else {
      return ApiErrorModel(data: "Unknown error occurred");
    }
  }
}

ApiErrorModel _handleError(dynamic data) {
  return ApiErrorModel(
    status: data['status'],
    code: data['code'],
    message: data['message'],
    data: data['data'],
  );
}