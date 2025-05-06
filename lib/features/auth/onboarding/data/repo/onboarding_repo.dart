import 'package:vibe_in/core/networking/api_error_handler.dart';
import 'package:vibe_in/core/networking/api_result.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/features/auth/onboarding/data/models/onboarding_model.dart';

class OnboardingRepo {
  final ApiService _apiService;

  OnboardingRepo(this._apiService);

  Future<ApiResult<OnboardingModel>> getOnboarding() async {
    try {
      final response = await _apiService.getOnboarding();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
