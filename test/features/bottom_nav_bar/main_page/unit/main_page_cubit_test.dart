import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/core/networking/generic_api_response.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/slider_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/repo/main_page_repo.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/models/category_model.dart';

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
  late MainPageRepo mainPageRepo;
  late MainPageCubit mainPageCubit;
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
    mainPageRepo = MainPageRepo(apiService);
    mainPageCubit = MainPageCubit(mainPageRepo);
  }

  blocTest<MainPageCubit, MainPageState>(
    '✅ emits [loading, success] when getSliders succeeds',
    setUp: () async {
      server = await startMockServer(
        responseBody: ApiResponse(
          status: true,
          code: 200,
          message: "Success",
          data: [
            SliderModel(id: 1, image: "https://example.com/slider1.jpg"),
            SliderModel(id: 2, image: "https://example.com/slider2.jpg"),
          ],
        ),
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getSliders(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.sliderState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.sliderState, 'success', RequestsStatus.success)
              .having((s) => s.sliderModel?.length, 'slider count', 2)
              .having(
                (s) => s.sliderModel?.first.image,
                'first image',
                contains('slider1'),
              ),
        ],
    tearDown: () async {
      await mainPageCubit.close();
      await server.close(force: true);
    },
  );

  blocTest<MainPageCubit, MainPageState>(
    '❌ emits [loading, error] when getSliders fails with 422',
    setUp: () async {
      server = await startMockServer(
        statusCode: 422,
        responseBody: {
          "status": false,
          "code": 422,
          "message": "Validation Error",
          "data": {
            "slider": ["Slider fetch failed"],
          },
        },
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getSliders(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.sliderState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.sliderState, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error message',
                contains('Slider fetch failed'),
              ),
        ],
    tearDown: () async {
      await mainPageCubit.close();
      await server.close(force: true);
    },
  );

  blocTest<MainPageCubit, MainPageState>(
    '📡 emits [loading, error] when getSliders fails due to no internet',
    setUp: () async {
      dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:0/', // غير موجود فعليًا
          connectTimeout: const Duration(milliseconds: 100),
          validateStatus: (_) => true,
        ),
      );
      apiService = ApiService(dio);
      mainPageRepo = MainPageRepo(apiService);
      mainPageCubit = MainPageCubit(mainPageRepo);
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getSliders(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.sliderState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.sliderState, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error',
                anyOf(
                  contains('no internet connection'),
                  contains('no_internet_connection'),
                ),
              ),
        ],
    tearDown: () async {
      await mainPageCubit.close();
    },
  );

  blocTest<MainPageCubit, MainPageState>(
    '⏱ emits [loading, error] when getSliders fails with timeout',
    setUp: () async {
      dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:1234/',
          connectTimeout: const Duration(milliseconds: 1),
          receiveTimeout: const Duration(milliseconds: 1),
          validateStatus: (_) => true,
        ),
      );
      apiService = ApiService(dio);
      mainPageRepo = MainPageRepo(apiService);
      mainPageCubit = MainPageCubit(mainPageRepo);
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getSliders(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.sliderState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.sliderState, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error',
                anyOf(
                  contains('timeout'),
                  contains('connection timeout'),
                  contains('receive timeout'),
                ),
              ),
        ],
    tearDown: () async {
      await mainPageCubit.close();
    },
  );

  //!------------------------------
  blocTest<MainPageCubit, MainPageState>(
    '✅ emits [loading, success] when getBestSellerProducts succeeds',
    setUp: () async {
      server = await startMockServer(
        responseBody: ApiResponse(
          status: true,
          code: 200,
          message: "Success",
          data: [
            ProductModel(
              id: 1,
              name: "Product 1",
              description: "desc",
              label: "Hot",
              images: ["https://example.com/p1.jpg"],
              category: CategoryModel(id: 1, name: "Fruits"),
              prices: [
                PricesModel(id: 1, weight: "1kg", price: "20", quantity: "1"),
              ],
              brand: Brand(id: 1, name: "Brand A"),
            ),
          ],
        ),
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getBestSellerProducts(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.bestSellerState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having(
                (s) => s.bestSellerState,
                'success',
                RequestsStatus.success,
              )
              .having((s) => s.bestSellerModel?.length, 'count', 1)
              .having(
                (s) => s.bestSellerModel?.first.name,
                'name',
                'Product 1',
              ),
        ],
    tearDown: () async {
      await mainPageCubit.close();
      await server.close(force: true);
    },
  );

  blocTest<MainPageCubit, MainPageState>(
    '❌ emits [loading, error] when getBestSellerProducts fails with 422',
    setUp: () async {
      server = await startMockServer(
        statusCode: 422,
        responseBody: {
          "status": false,
          "code": 422,
          "message": "Validation Error",
          "data": {
            "product": ["Product fetch failed"],
          },
        },
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getBestSellerProducts(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.bestSellerState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.bestSellerState, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error message',
                contains('Product fetch failed'),
              ),
        ],
    tearDown: () async {
      await mainPageCubit.close();
      await server.close(force: true);
    },
  );

  blocTest<MainPageCubit, MainPageState>(
    '📡 emits [loading, error] when getBestSellerProducts fails due to no internet',
    setUp: () async {
      dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:0/',
          connectTimeout: const Duration(milliseconds: 100),
          validateStatus: (_) => true,
        ),
      );
      apiService = ApiService(dio);
      mainPageRepo = MainPageRepo(apiService);
      mainPageCubit = MainPageCubit(mainPageRepo);
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getBestSellerProducts(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.bestSellerState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.bestSellerState, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error',
                anyOf(
                  contains('no internet connection'),
                  contains('no_internet_connection'),
                ),
              ),
        ],
    tearDown: () async {
      await mainPageCubit.close();
    },
  );

  blocTest<MainPageCubit, MainPageState>(
    '⏱ emits [loading, error] when getBestSellerProducts fails with timeout',
    setUp: () async {
      dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:1234/',
          connectTimeout: const Duration(milliseconds: 1),
          receiveTimeout: const Duration(milliseconds: 1),
          validateStatus: (_) => true,
        ),
      );
      apiService = ApiService(dio);
      mainPageRepo = MainPageRepo(apiService);
      mainPageCubit = MainPageCubit(mainPageRepo);
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getBestSellerProducts(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.bestSellerState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.bestSellerState, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error',
                anyOf(
                  contains('timeout'),
                  contains('connection timeout'),
                  contains('receive timeout'),
                ),
              ),
        ],
    tearDown: () async {
      await mainPageCubit.close();
    },
  );

  //!------------------------------
  blocTest<MainPageCubit, MainPageState>(
    '✅ emits [loading, success] when getPackages succeeds',
    setUp: () async {
      server = await startMockServer(
        responseBody: ApiResponse(
          status: true,
          code: 200,
          message: "Success",
          data: [
            PackageModel(
              id: 1,
              name: "Package 1",
              description: "A full package",
              tags: "New,Fresh",
              products: [
                Products(
                  id: 1,
                  name: "Product 1",
                  image: "https://example.com/p1.jpg",
                  alternatives: [
                    Alternatives(
                      id: 1,
                      name: "Alternative 1",
                      image: "https://example.com/a1.jpg",
                      addOn: "10",
                    ),
                  ],
                ),
              ],
              images: [Images(id: 1, url: "https://example.com/i1.jpg")],
              cycles: [
                Cycles(
                  id: 1,
                  name: "Cycle 1",
                  status: 1,
                  days: ['Sat', 'Sun'],
                  daysCount: 4,
                  price: "20",
                ),
              ],
            ),
          ],
        ),
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getPackages(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.packagesState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.packagesState, 'success', RequestsStatus.success)
              .having((s) => s.packagesModel?.length, 'count', 1)
              .having((s) => s.packagesModel?.first.name, 'name', 'Package 1'),
        ],
    tearDown: () async {
      await mainPageCubit.close();
      await server.close(force: true);
    },
  );

  blocTest<MainPageCubit, MainPageState>(
    '❌ emits [loading, error] when getPackages fails with 422',
    setUp: () async {
      server = await startMockServer(
        statusCode: 422,
        responseBody: {
          "status": false,
          "code": 422,
          "message": "Validation Error",
          "data": {
            "packages": ["Invalid request"],
          },
        },
      );
      dynamicPort = server.port;
      setupCubit();
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getPackages(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.packagesState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.packagesState, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error message',
                contains('Invalid request'),
              ),
        ],
    tearDown: () async {
      await mainPageCubit.close();
      await server.close(force: true);
    },
  );

  // -----------------------------------------------------------------------------
  // getPackages – no internet
  // -----------------------------------------------------------------------------
  blocTest<MainPageCubit, MainPageState>(
    '📡 emits [loading, error] when getPackages fails due to no internet',
    setUp: () async {
      dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:0/',
          connectTimeout: const Duration(milliseconds: 100),
          validateStatus: (_) => true,
        ),
      );
      apiService = ApiService(dio);
      mainPageRepo = MainPageRepo(apiService);
      mainPageCubit = MainPageCubit(mainPageRepo);
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getPackages(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.packagesState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.packagesState, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error',
                anyOf(
                  contains('no internet connection'),
                  contains('no_internet_connection'),
                ),
              ),
        ],
    tearDown: () async => mainPageCubit.close(),
  );

  // -----------------------------------------------------------------------------
  // getPackages – timeout
  // -----------------------------------------------------------------------------
  blocTest<MainPageCubit, MainPageState>(
    '⏱ emits [loading, error] when getPackages fails with timeout',
    setUp: () async {
      dio = Dio(
        BaseOptions(
          baseUrl: 'http://localhost:1234/',
          connectTimeout: const Duration(milliseconds: 1),
          receiveTimeout: const Duration(milliseconds: 1),
          validateStatus: (_) => true,
        ),
      );
      apiService = ApiService(dio);
      mainPageRepo = MainPageRepo(apiService);
      mainPageCubit = MainPageCubit(mainPageRepo);
    },
    build: () => mainPageCubit,
    act: (cubit) => cubit.getPackages(),
    expect:
        () => [
          isA<MainPageState>().having(
            (s) => s.packagesState,
            'loading',
            RequestsStatus.loading,
          ),
          isA<MainPageState>()
              .having((s) => s.packagesState, 'error', RequestsStatus.error)
              .having(
                (s) => s.error,
                'error',
                anyOf(
                  contains('timeout'),
                  contains('connection timeout'),
                  contains('receive timeout'),
                ),
              ),
        ],
    tearDown: () async => mainPageCubit.close(),
  );
}
