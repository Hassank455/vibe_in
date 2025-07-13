// import 'package:flutter_test/flutter_test.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
// import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_state.dart';
// import 'package:vibe_in/features/bottom_nav_bar/products/data/repo/products_repo.dart';
// import 'package:vibe_in/features/bottom_nav_bar/main_page/data/repo/main_page_repo.dart';
// import 'package:mocktail/mocktail.dart';

// class MockProductsRepo extends Mock implements ProductsRepo {}
// class MockMainPageRepo extends Mock implements MainPageRepo {}

// void main() {
//   late ProductsCubit productsCubit;
//   late ProductsRepo productsRepo;
//   late MainPageRepo mainPageRepo;

//   setUp(() {
//     productsRepo = MockProductsRepo();
//     mainPageRepo = MockMainPageRepo();
//     productsCubit = ProductsCubit(productsRepo, mainPageRepo);
//   });

//   tearDown(() async {
//     await productsCubit.close();
//   });

//   // ---------------------------------------------------------------------------
//   blocTest<ProductsCubit, ProductsState>(
//     '📍 emits new index when changeTab is called',
//     build: () => productsCubit,
//     act: (cubit) => cubit.changeTab(2),
//     expect: () => [
//       isA<ProductsState>().having((s) => s.currentIndex, 'currentIndex', 2),
//     ],
//   );

//   // ---------------------------------------------------------------------------
//   blocTest<ProductsCubit, ProductsState>(
//     '➕ adds category when selectCategory is called and it was not selected',
//     build: () => productsCubit,
//     act: (cubit) => cubit.selectCategory(5),
//     expect: () => [
//       isA<ProductsState>().having((s) => s.selectedCategory, 'selectedCategory', contains(5)),
//     ],
//   );

//   // ---------------------------------------------------------------------------
//   blocTest<ProductsCubit, ProductsState>(
//     '➖ removes category when selectCategory is called and it was already selected',
//     build: () => productsCubit,
//     seed: () => const ProductsState(selectedCategory: [1, 5, 9]),
//     act: (cubit) => cubit.selectCategory(5),
//     expect: () => [
//       isA<ProductsState>().having((s) => s.selectedCategory, 'selectedCategory', [1, 9]),
//     ],
//   );

//   // ---------------------------------------------------------------------------
//   blocTest<ProductsCubit, ProductsState>(
//     '🧼 resets all selected categories when resetCategories is called',
//     build: () => productsCubit,
//     seed: () => const ProductsState(selectedCategory: [3, 7]),
//     act: (cubit) => cubit.resetCategories(),
//     expect: () => [
//       isA<ProductsState>().having((s) => s.selectedCategory, 'selectedCategory', isEmpty),
//     ],
//   );
// }

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
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/models/category_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/repo/products_repo.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/repo/main_page_repo.dart';

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
    apiService = ApiService(dio);
    productsRepo = ProductsRepo(apiService);
    mainPageRepo = MainPageRepo(apiService);
    productsCubit = ProductsCubit(productsRepo, mainPageRepo);
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
    tearDown: () async {
      await productsCubit.close();
      await server.close(force: true);
    },
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
    tearDown: () async {
      await productsCubit.close();
      await server.close(force: true);
    },
  );
}
