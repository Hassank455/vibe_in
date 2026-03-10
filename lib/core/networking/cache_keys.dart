class CacheKeys {
static const sliders = 'sliders_v1';
static String bestSellers({required int perPage, required int page}) => 'bestSellers_v1_p${page}_pp${perPage}';
static String packages({required int perPage, required int page, String? search}) => 'packages_v1_p${page}_pp${perPage}_s${search ?? ''}';
static String products({required int perPage, required int page, String? categories, String? search})
=> 'products_v1_p${page}_pp${perPage}_c${categories ?? ''}_s${search ?? ''}';
}