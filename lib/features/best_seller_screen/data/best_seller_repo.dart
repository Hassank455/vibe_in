import 'package:vibe_in/core/networking/api_error_handler.dart';
import 'package:vibe_in/core/networking/api_result.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/core/networking/generic_api_response.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/slider_model.dart';

class BestSellerRepo {
  final ApiService _apiService;

  BestSellerRepo(this._apiService);

  Future<ApiResult<ApiResponse<List<ProductModel>>>> getBestSellerProducts({
    required int perPage,
    required int page,
  }) async {
    try {
      final response = await _apiService.getBestSellerProducts(perPage, page);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
