import 'package:dio/dio.dart';
import 'package:vibe_in/core/networking/api_error_handler.dart';
import 'package:vibe_in/core/networking/api_result.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/core/networking/cache_keys.dart';
import 'package:vibe_in/core/networking/generic_api_response.dart';
import 'package:vibe_in/core/networking/local_offline_store.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/slider_model.dart';

class MainPageRepoCached {
  MainPageRepoCached(
    this._api,
    this._store, {
    this.softTtl = const Duration(minutes: 10),
  });
  final ApiService _api;
  final LocalOfflineStore _store;
  final Duration softTtl;

  bool _isStale(String key) {
    final ts = _store.lastSync(key);
    return ts == null || DateTime.now().difference(ts) > softTtl;
  }

  Future<ApiResult<List<SliderModel>>> getSliders() async {
    const key = CacheKeys.sliders;

    // 1) اقرأ المحلي
    final local = _store.readJsonList(key);
    if (local != null && local.isNotEmpty) {
      // تحديث صامت لو قديم
      if (_isStale(key)) {
        _refreshSlidersSilently();
      }
      try {
        final items =
            local
                .map((e) => SliderModel.fromJson(Map<String, dynamic>.from(e)))
                .toList();
        return ApiResult.success(items);
      } catch (_) {
        /* لو local فيه خلل رجّع للنت */
      }
    }
    // 2) شبكة + حفظ محلي
    
  }

  Future<void> _refreshBestSellersSilently({
    required int perPage,
    required int page,
  }) async {
    try {
      final response = await _api.getBestSellerProducts(perPage, page);
      await _store
          .saveJson(CacheKeys.bestSellers(perPage: perPage, page: page), {
            'data': response.data.map((e) => e.toJson()).toList(),
            'message': response.message,
            'status': response.status,
          });
    } catch (_) {}
  }

  Future<ApiResult<ApiResponse<List<PackageModel>>>> getPackages({
    required int perPage,
    required int page,
    String? search,
  }) async {
    final key = CacheKeys.packages(
      perPage: perPage,
      page: page,
      search: search,
    );

    final local = _store.readJsonObject(key);
    if (local != null && local['data'] is List) {
      if (_isStale(key)) {
        _refreshPackagesSilently(perPage: perPage, page: page, search: search);
      }
      try {
        final list =
            (local['data'] as List)
                .map((e) => PackageModel.fromJson(Map<String, dynamic>.from(e)))
                .toList();
        return ApiResult.success(
          ApiResponse<List<PackageModel>>(
            data: list,
            code: local['code'],
            message: local['message'],
            status: local['status'],
          ),
        );
      } catch (_) {}
    }

    try {
      final response = await _api.getPackages(perPage, page, search);
      await _store.saveJson(key, {
        'data': response.data.map((e) => e.toJson()).toList(),
        'message': response.message,
        'status': response.status,
      });
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  Future<void> _refreshPackagesSilently({
    required int perPage,
    required int page,
    String? search,
  }) async {
    try {
      final response = await _api.getPackages(perPage, page, search);
      await _store.saveJson(
        CacheKeys.packages(perPage: perPage, page: page, search: search),
        {
          'data': response.data.map((e) => e.toJson()).toList(),
          'message': response.message,
          'status': response.status,
        },
      );
    } catch (_) {}
  }
}
