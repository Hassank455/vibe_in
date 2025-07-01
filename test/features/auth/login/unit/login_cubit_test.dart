import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/features/auth/login/data/models/login_response.dart';
import 'package:vibe_in/features/auth/login/data/repo/login_repo.dart';
import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';
import 'package:vibe_in/features/auth/login/cubit/login_state.dart';

/// Runs a dynamic mock server that returns a custom response body.
Future<HttpServer> startDynamicMockServer({
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
    '✅ Dynamic mock server running on http://${server.address.host}:${server.port}',
  );
  return server;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = null;
  late Dio dio;
  late ApiService apiService;
  late LoginRepo loginRepo;
  late LoginCubit loginCubit;
  late HttpServer server;
  late int dynamicPort;

  void setUpCubit() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:$dynamicPort/',
        // validateStatus: (_) => true,
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
    loginRepo = LoginRepo(apiService);
    loginCubit = LoginCubit(loginRepo);
  }

  blocTest<LoginCubit, LoginState>(
    '✅ emits [LoadingLoginState, SuccessLoginState]',
    setUp: () async {
      server = await startDynamicMockServer(
        // responseBody: {
        //   "status": true,
        //   "code": 200,
        //   "message": "OTP sent successfully",
        //   "data": {"otp": "1111"},
        // },
        responseBody: LoginResponse(
          status: true,
          code: 200,
          message: 'OTP sent successfully',
          data: Data(otp: '1111'),
        ),
      );
      dynamicPort = server.port;
      setUpCubit();
    },
    tearDown: () async {
      loginCubit.close();
      await server.close(force: true);
    },
    build: () => loginCubit,
    act: (cubit) {
      cubit.phoneController.text = '512345678';
      return cubit.emitLoginStates();
    },
    expect:
        () => [
          isA<LoadingLoginState>(),
          isA<SuccessLoginState>().having(
            (s) => s.loginResponse.data?.otp,
            'otp',
            '1111',
          ),
        ],
  );

  blocTest<LoginCubit, LoginState>(
    '❌ emits [LoadingLoginState, ErrorLoginState] with 422 error',
    setUp: () async {
      server = await startDynamicMockServer(
        responseBody: {
          "status": false,
          "code": 422,
          "message": "Validation Error",
          "data": {
            "phone": ["Phone is required"],
          },
        },
        statusCode: 422,
      );
      dynamicPort = server.port;
      setUpCubit();
    },
    tearDown: () async {
      loginCubit.close();
      await server.close(force: true);
    },
    build: () => loginCubit,
    act: (cubit) {
      cubit.phoneController.text = 'invalid';
      return cubit.emitLoginStates();
    },
    expect:
        () => [
          isA<LoadingLoginState>(),
          isA<ErrorLoginState>().having(
            (e) => e.error,
            'error',
            contains('Phone is required'),
          ),
        ],
  );

  blocTest<LoginCubit, LoginState>(
    '💥 emits [LoadingLoginState, ErrorLoginState] when server returns 500',
    setUp: () async {
      server = await startDynamicMockServer(
        responseBody: {
          "status": false,
          "code": 500,
          "message": "Internal server error",
          "data": "Internal server error",
        },
        statusCode: 500,
      );
      dynamicPort = server.port;
      setUpCubit();
    },
    tearDown: () async {
      loginCubit.close();
      await server.close(force: true);
    },
    build: () => loginCubit,
    act: (cubit) {
      cubit.phoneController.text = 'any';
      return cubit.emitLoginStates();
    },
    expect:
        () => [
          isA<LoadingLoginState>(),
          isA<ErrorLoginState>().having(
            (e) => e.error?.toLowerCase(),
            'error',
            contains('internal'),
          ),
        ],
  );
}
