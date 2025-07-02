import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(data: 'connection_failed'.tr());
        case DioExceptionType.cancel:
          return ApiErrorModel(data: 'request_cancelled'.tr());
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(data: 'connection_timeout'.tr());
        case DioExceptionType.unknown:
          return ApiErrorModel(data: 'no_internet_connection'.tr());
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(data: 'receive_timeout'.tr());
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(data: 'send_timeout'.tr());
        default:
          return ApiErrorModel(data: 'something_went_wrong'.tr());
      }
    } else {
      return ApiErrorModel(data: 'unknown_error'.tr());
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
