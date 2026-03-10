import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:path_provider/path_provider.dart';

class DioCacheBootstrap {
  static Future<Interceptor> buildCacheInterceptor() async {
    final dir = await getApplicationDocumentsDirectory();

    // ✅ استخدم HttpCacheHiveStore بدل HiveCacheStore القديم
    final store = HiveCacheStore(dir.path);

    final cacheOptions = CacheOptions(
      store: store,
      policy: CachePolicy.request, // يحترم ETag/Cache-Control
      // hitCacheOnErrorExcept: [401, 403],
      hitCacheOnErrorCodes: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      allowPostMethod: false,
    );

    return DioCacheInterceptor(options: cacheOptions);
  }
}
