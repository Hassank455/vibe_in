import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_cubit.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_state.dart';
import 'package:vibe_in/features/auth/verification/data/model/verification_response.dart';
import 'package:vibe_in/features/auth/verification/data/repo/verification_repo.dart';

// Runs a dynamic mock server that returns a custom response body.
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
  late VerificationRepo verificationRepo;
  late VerificationCubit verificationCubit;
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
    verificationRepo = VerificationRepo(apiService);
    verificationCubit = VerificationCubit(verificationRepo);
  }

  blocTest<VerificationCubit, VerificationState>(
    '✅ emits [loading, success]',
    setUp: () async {
      server = await startDynamicMockServer(
        responseBody: VerificationResponse(
          status: true,
          code: 200,
          message: 'OTP sent successfully',
          data: Data(
            token: 'token',
            user: User(
              id: 1,
              name: 'Hassan',
              phone: '512345678',
              avatar: 'https://example.com/avatar.png',
            ),
          ),
        ),
      );
      dynamicPort = server.port;
      setUpCubit();
    },
    tearDown: () async {
      print('✅ Dynamic mock server closed');
      // verificationCubit.close();
      await server.close(force: true);
    },
    build: () => verificationCubit,
    act: (cubit) {
      cubit.init('512345678', '1234');
      return cubit.otpVerification();
    },
    expect:
        () => [
          isA<VerificationState>().having(
            (s) => s.verificationStatus,
            'loading',
            RequestsStatus.loading,
          ),
          isA<VerificationState>().having(
            (s) => s.verificationStatus,
            'success',
            RequestsStatus.success,
          ),
        ],
  );

  blocTest<VerificationCubit, VerificationState>(
    '❌ emits [loading, error] when OTP is invalid (422)',
    setUp: () async {
      server = await startDynamicMockServer(
        responseBody: {
          "status": false,
          "code": 422,
          "message": "Validation Error",
          "data": {
            "otp": ["Invalid OTP"],
          },
        },
        statusCode: 422,
      );
      dynamicPort = server.port;

      setUpCubit();
    },
    build: () => verificationCubit,
    act: (cubit) {
      cubit.init('512345678', 'wrong_otp');
      return cubit.otpVerification();
    },
    expect:
        () => [
          isA<VerificationState>().having(
            (s) => s.verificationStatus,
            'loading',
            RequestsStatus.loading,
          ),
          isA<VerificationState>()
              .having(
                (s) => s.verificationStatus,
                'error',
                RequestsStatus.error,
              )
              .having((s) => s.error, 'error message', contains('Invalid OTP')),
        ],
    tearDown: () async {
      // await verificationCubit.close();
      await server.close(force: true);
    },
  );

  blocTest<VerificationCubit, VerificationState>(
    '💥 emits [loading, error] when server returns 500',
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
    build: () => verificationCubit,
    act: (cubit) {
      cubit.init('512345678', '1234');
      return cubit.otpVerification();
    },
    expect:
        () => [
          isA<VerificationState>().having(
            (s) => s.verificationStatus,
            'loading',
            RequestsStatus.loading,
          ),
          isA<VerificationState>()
              .having(
                (s) => s.verificationStatus,
                'error',
                RequestsStatus.error,
              )
              .having(
                (s) => s.error?.toLowerCase(),
                'error message',
                contains('internal'),
              ),
        ],
    tearDown: () async {
      //await verificationCubit.close();
      await server.close(force: true);
    },
  );
  test('⏱️ startTimer decreases time every second', () async {
    dio = Dio(
      BaseOptions(baseUrl: 'http://localhost:0/', validateStatus: (_) => true),
    );
    apiService = ApiService(dio);
    verificationRepo = VerificationRepo(apiService);
    verificationCubit = VerificationCubit(verificationRepo);

    verificationCubit.emit(verificationCubit.state.copyWith(start: 3));
    verificationCubit.startTimer();

    await Future.delayed(Duration(seconds: 4));

    expect(verificationCubit.state.start, 0);
    await verificationCubit.close();
  });

  test('🕒 formatTime returns correct mm:ss', () {
    dio = Dio(
      BaseOptions(baseUrl: 'http://localhost:0/', validateStatus: (_) => true),
    );
    apiService = ApiService(dio);
    verificationRepo = VerificationRepo(apiService);
    verificationCubit = VerificationCubit(verificationRepo);

    verificationCubit.emit(verificationCubit.state.copyWith(start: 3));

    verificationCubit.emit(
      verificationCubit.state.copyWith(start: 125),
    ); // 2m 5s

    final formatted = verificationCubit.formatTime();
    expect(formatted, '02:05');
  });
}
