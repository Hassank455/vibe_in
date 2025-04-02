
import 'package:vibe_in/core/networking/api_error_model.dart';

class ApiResult<T> {
  final T? data;
  final ApiErrorModel? errorHandler;

  ApiResult._({this.data, this.errorHandler});

  factory ApiResult.success(T data) {
    return ApiResult._(data: data);
  }

  factory ApiResult.failure(ApiErrorModel errorHandler) {
    return ApiResult._(errorHandler: errorHandler);
  }

  bool get isSuccess => data != null;

  bool get isFailure => errorHandler != null;
}