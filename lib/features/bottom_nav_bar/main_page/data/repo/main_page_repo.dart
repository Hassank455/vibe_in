import 'package:vibe_in/core/networking/api_error_handler.dart';
import 'package:vibe_in/core/networking/api_result.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/slider_model.dart';

class MainPageRepo {
  final ApiService _apiService;

  MainPageRepo(this._apiService);

  Future<ApiResult<SliderModel>> getSliders() async {
    try {
      final response = await _apiService.getSliders();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
