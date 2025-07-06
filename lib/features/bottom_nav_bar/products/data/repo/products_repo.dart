import 'package:vibe_in/core/networking/api_error_handler.dart';
import 'package:vibe_in/core/networking/api_result.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/core/networking/generic_api_response.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/models/category_model.dart';

class ProductsRepo {
  final ApiService _apiService;

  ProductsRepo(this._apiService);

  Future<ApiResult<ApiResponse<List<CategoryModel>>>> getCategories() async {
    try {
      final response = await _apiService.getCategories();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ApiResponse<List<ProductModel>>>> getProducts({
    required int perPage,
    required int page,
    List<int>? categories,
    String? search,
  }) async {
    try {
      final response = await _apiService.getProducts(
        perPage,
        page,
        categories?.join(','),
        search,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
