import 'dart:io';
import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/core/networking/generic_api_response.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/models/category_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/repo/products_repo.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/repo/main_page_repo.dart';

ProductModel product1 = ProductModel(
  id: 1,
  name: "Product 1",
  description: "desc",
  label: "Hot",
  images: ["https://example.com/p1.jpg"],
  category: CategoryModel(id: 1, name: "Fruits"),
  prices: [PricesModel(id: 1, weight: "1kg", price: "20", quantity: "1")],
  brand: Brand(id: 1, name: "Brand A"),
);
ProductModel product2 = ProductModel(
  id: 2,
  name: "Product 2",
  description: "desc",
  label: "Hot",
  images: ["https://example.com/p2.jpg"],
  category: CategoryModel(id: 1, name: "Fruits"),
  prices: [PricesModel(id: 2, weight: "1kg", price: "20", quantity: "1")],
  brand: Brand(id: 1, name: "Brand A"),
);

Future<HttpServer> startMockServer({
  required dynamic responseBody,
  int statusCode = 200,
}) async {
  handler(shelf.Request request) async {
    final bodyString =
        responseBody is String ? responseBody : jsonEncode(responseBody);
    return shelf.Response(
      statusCode,
      body: bodyString,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
  }

  final server = await shelf_io.serve(handler, 'localhost', 0);
  print(
    '✅ Mock server running on http://${server.address.host}:${server.port}',
  );
  return server;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = null;

  late Dio dio;
  late ApiService apiService;
  late ProductsRepo productsRepo;
  late MainPageRepo mainPageRepo;
  late ProductsCubit productsCubit;
  late HttpServer server;
  late int dynamicPort;

  void setupCubit() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:$dynamicPort/',
        validateStatus: (status) => status! < 400,
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
    apiService = ApiService(dio);
    productsRepo = ProductsRepo(apiService);
    mainPageRepo = MainPageRepo(apiService);
    productsCubit = ProductsCubit(productsRepo, mainPageRepo);
  }

  Future<void> cleanUp() async {
  await productsCubit.close();
  await server.close(force: true);
}

  // 📍 emits new index when changeTab is called
  blocTest<ProductsCubit, ProductsState>(
    '📍 emits new index when changeTab is called',
    build: () => ProductsCubit(productsRepo, mainPageRepo),
    setUp: () {
      dynamicPort = 0;
      setupCubit();
    },
    act: (cubit) => cubit.changeTab(2),
    expect:
        () => [isA<ProductsState>().having((s) => s.currentIndex, 'index', 2)],
  );

  // ➕ adds category when selectCategory is called and it was not selected
  blocTest<ProductsCubit, ProductsState>(
    '➕ adds category when selectCategory is called and it was not selected',
    build: () => ProductsCubit(productsRepo, mainPageRepo),
    setUp: () {
      dynamicPort = 0;
      setupCubit();
    },
    act: (cubit) => cubit.selectCategory(5),
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.selectedCategory,
            'selected',
            contains(5),
          ),
        ],
  );

  // ➖ removes category when selectCategory is called and it was already selected
  blocTest<ProductsCubit, ProductsState>(
    '➖ removes category when selectCategory is called and it was already selected',
    build:
        () =>
            ProductsCubit(productsRepo, mainPageRepo)
              ..emit(const ProductsState(selectedCategory: [5])),
    act: (cubit) => cubit.selectCategory(5),
    setUp: () {
      dynamicPort = 0;
      setupCubit();
    },
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.selectedCategory,
            'selected',
            isEmpty,
          ),
        ],
  );

  // 🧼 resets all selected categories when resetCategories is called
  blocTest<ProductsCubit, ProductsState>(
    '🧼 resets all selected categories when resetCategories is called',
    build:
        () =>
            ProductsCubit(productsRepo, mainPageRepo)
              ..emit(const ProductsState(selectedCategory: [1, 2, 3])),
    act: (cubit) => cubit.resetCategories(),
    setUp: () {
      dynamicPort = 0;
      setupCubit();
    },
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.selectedCategory,
            'reset',
            isEmpty,
          ),
        ],
  );
  blocTest<ProductsCubit, ProductsState>(
    '🚀 emits [loading, success] when getCategories succeeds',
    setUp: () async {
      server = await startMockServer(
        responseBody: ApiResponse(
          status: true,
          code: 200,
          message: "Success",
          data: [
            CategoryModel(id: 1, name: "Vegetables"),
            CategoryModel(id: 2, name: "Fruits"),
          ],
        ),
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => productsCubit,
    act: (cubit) => cubit.getCategories(),
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.categoryStatus,
            'loading',
            RequestsStatus.loading,
          ),
          isA<ProductsState>()
              .having(
                (s) => s.categoryStatus,
                'success',
                RequestsStatus.success,
              )
              .having((s) => s.categoryModel!.length, 'category count', 2),
        ],
    tearDown: cleanUp,
  );

  blocTest<ProductsCubit, ProductsState>(
    '❌ emits [loading, error] when getCategories fails with 422',
    setUp: () async {
      server = await startMockServer(
        statusCode: 422,
        responseBody: {
          "status": false,
          "code": 422,
          "message": "Validation Error",
          "data": {
            "category": ["Category fetch failed"],
          },
        },
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => productsCubit,
    act: (cubit) => cubit.getCategories(),
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.categoryStatus,
            'loading',
            RequestsStatus.loading,
          ),
          isA<ProductsState>()
              .having((s) => s.categoryStatus, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error message',
                contains('Category fetch failed'),
              ),
        ],
    tearDown: cleanUp,
  );

  // 📦 emits [loading, success] when refreshProducts is called (initial load)
  blocTest<ProductsCubit, ProductsState>(
    '📦 emits [loading, success] when refreshProducts is called (initial)',
    setUp: () async {
      server = await startMockServer(
        responseBody: ApiResponse(
          status: true,
          code: 200,
          message:
              "", // If you set Success, you are saying that this value is required for the test to pass, which it is not.
          data: [product1],
        ),
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => productsCubit,
    act: (cubit) => cubit.refreshProducts(),
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.productsStatus,
            'loading',
            RequestsStatus.loading,
          ),
          isA<ProductsState>()
              .having(
                (s) => s.productsStatus,
                'success',
                RequestsStatus.success,
              )
              .having((s) => s.productModel?.length, 'products length', 1),
        ],
    tearDown: cleanUp,
  );

  blocTest<ProductsCubit, ProductsState>(
    '📦 emits [loading, success] with empty list',
    setUp: () async {
      server = await startMockServer(
        responseBody: ApiResponse(
          status: true,
          code: 200,
          message: "",
          data: [], // 🟢 تحقق أن هذا لا يكسر الكود
        ),
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => productsCubit,
    act: (cubit) => cubit.refreshProducts(),
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.productsStatus,
            'loading',
            RequestsStatus.loading,
          ),
          isA<ProductsState>()
              .having((s) => s.productsStatus, 'status', RequestsStatus.success)
              .having((s) => s.productModel?.isEmpty, 'empty list', true)
              .having((s) => s.productModel?.length, 'products length', 0),
        ],
    tearDown: cleanUp,
  );

  // 📦 getProducts: success (load more)
  blocTest<ProductsCubit, ProductsState>(
    '📦 emits [load more loading, success] when loading page 2 with perPage=10 and total=80',
    setUp: () async {
      final firstPageProducts = List.generate(
        10,
        (index) =>
            product1.copyWith(id: index + 1, name: 'Product ${index + 1}'),
      );

      final secondPageProducts = List.generate(
        10,
        (index) =>
            product2.copyWith(id: index + 11, name: 'Product ${index + 11}'),
      );
      server = await startMockServer(
        responseBody: ApiResponse(
          status: true,
          code: 200,
          message: "",
          data: secondPageProducts,
          pagination: Pagination(
            currentPage: 2,
            lastPage: 8,
            perPage: 10,
            total: 80,
          ),
        ),
      );
      dynamicPort = server.port;
      setupCubit();
      productsCubit.emit(
        productsCubit.state.copyWith(productModel: firstPageProducts),
      );
      // productsCubit.emit(
      //   productsCubit.state.copyWith(productModel: [product2]),
      // );
    },
    build: () => productsCubit,
    act: (cubit) => cubit.refreshProducts(loadMore: true),
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.isLoadingMoreProduct,
            'loading more',
            true,
          ),
          isA<ProductsState>()
              .having((s) => s.productsStatus, 'status', RequestsStatus.success)
              // .having((s) => s.productModel?.length, 'length', 2),
              .having(
                (s) => s.productModel?.map((e) => e.id).toList(),
                'merged product ids',
                List.generate(20, (i) => i + 1), // [1, 2, ..., 20]
              ),
        ],
    tearDown: cleanUp,
  );

  // ❌ getProducts: error (initial load)
  blocTest<ProductsCubit, ProductsState>(
    '❌ emits [loading, error] when refreshProducts fails initially',
    setUp: () async {
      server = await startMockServer(
        statusCode: 422,
        responseBody: {
          "status": false,
          "code": 422,
          "message": "",
          "data": {
            "product": ["This is an error message"],
          },
        },
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => productsCubit,
    act: (cubit) => cubit.refreshProducts(),
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.productsStatus,
            'loading',
            RequestsStatus.loading,
          ),
          isA<ProductsState>()
              .having((s) => s.productsStatus, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error message',
                contains('This is an error message'),
              ),
        ],
    tearDown: cleanUp,
  );

  // ❌ getProducts: error (load more)
  blocTest<ProductsCubit, ProductsState>(
    '❌ emits [load more loading, error] when refreshProducts fails with loadMore = true',
    setUp: () async {
      server = await startMockServer(statusCode: 500, responseBody: {});
      dynamicPort = server.port;
      setupCubit();
      productsCubit.emit(
        productsCubit.state.copyWith(productModel: [product1]),
      );
    },
    build: () => productsCubit,
    act: (cubit) => cubit.refreshProducts(loadMore: true),
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.isLoadingMoreProduct,
            'loading more',
            true,
          ),
          isA<ProductsState>().having(
            (s) => s.productsStatus,
            'error',
            RequestsStatus.error,
          ),
        ],
    tearDown: cleanUp,
  );

  blocTest<ProductsCubit, ProductsState>(
    '🌐 emits [loading, error] when refreshProducts fails due to no internet',
    setUp: () {
      dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:0/',
          connectTimeout: const Duration(milliseconds: 100),
          receiveTimeout: const Duration(milliseconds: 100),
          validateStatus: (_) => true,
        ),
      );
      apiService = ApiService(dio);
      productsRepo = ProductsRepo(apiService);
      mainPageRepo = MainPageRepo(apiService);
      productsCubit = ProductsCubit(productsRepo, mainPageRepo);
    },
    build: () => productsCubit,
    act: (cubit) => cubit.refreshProducts(),
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.productsStatus,
            'loading',
            RequestsStatus.loading,
          ),
          isA<ProductsState>()
              .having((s) => s.productsStatus, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error message',
                anyOf(
                  contains('no_internet_connection'),
                  contains('timeout'),
                  contains('connection_failed'),
                ),
              ),
        ],
    tearDown: () async {
      await productsCubit.close();
    },
  );
  blocTest<ProductsCubit, ProductsState>(
    '⏱️ emits [loading, error] when refreshProducts times out initially',
    setUp: () {
      dio = Dio(
        BaseOptions(
          baseUrl: 'http://10.255.255.1/', // simulate timeout
          connectTimeout: const Duration(milliseconds: 100),
          receiveTimeout: const Duration(milliseconds: 100),
          validateStatus: (_) => true,
        ),
      );
      apiService = ApiService(dio);
      productsRepo = ProductsRepo(apiService);
      mainPageRepo = MainPageRepo(apiService);
      productsCubit = ProductsCubit(productsRepo, mainPageRepo);
    },
    build: () => productsCubit,
    act: (cubit) => cubit.refreshProducts(),
    expect:
        () => [
          isA<ProductsState>().having(
            (s) => s.productsStatus,
            'loading',
            RequestsStatus.loading,
          ),
          isA<ProductsState>()
              .having((s) => s.productsStatus, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error message',
                anyOf(contains('timeout'), contains('timed out')),
              ),
        ],
    tearDown: () async => await productsCubit.close(),
  );
}
