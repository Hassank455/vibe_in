import 'package:vibe_in/core/networking/api_error_handler.dart';
import 'package:vibe_in/core/networking/api_result.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/core/networking/generic_api_response.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/slider_model.dart';

class MainPageRepo {
  final ApiService _apiService;

  MainPageRepo(this._apiService);

  Future<ApiResult<List<SliderModel>>> getSliders() async {
    try {
      final response = await _apiService.getSliders();
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<ProductModel>>> getBestSellerProducts({
    required int perPage,
  }) async {
    try {
      final response = await _apiService.getBestSellerProducts(perPage, 1);
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ApiResponse<List<PackageModel>>>> getPackages({
    required int perPage,
    required int page,
    String? search,
  }) async {
    try {
      final response = await _apiService.getPackages(perPage, page,search);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
