import 'package:vibe_in/core/networking/api_error_handler.dart';
import 'package:vibe_in/core/networking/api_result.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/features/auth/login/data/models/login_request_body.dart';
import 'package:vibe_in/features/auth/login/data/models/login_response.dart';
import 'package:vibe_in/features/auth/verification/data/model/verification_request_body.dart';
import 'package:vibe_in/features/auth/verification/data/model/verification_response.dart';

class VerificationRepo {
  final ApiService _apiService;

  VerificationRepo(this._apiService);

  Future<ApiResult<VerificationResponse>> checkOTP(
    VerificationRequestBody verificationRequestBody,
  ) async {
    try {
      final response = await _apiService.checkOTP(verificationRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
  Future<ApiResult<LoginResponse>> resendCode(
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
