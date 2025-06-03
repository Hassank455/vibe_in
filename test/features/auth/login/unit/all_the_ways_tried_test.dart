// import 'dart:convert';
// import 'dart:io';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:dio/dio.dart';
// import 'package:shelf/shelf.dart' as shelf; // ✅ هذا هو المهم

// import 'package:shelf/shelf_io.dart' as shelf_io;

// import 'mock_server.dart'; // ⬅️ هنا السيرفر الديناميكي
// import 'package:vibe_in/core/networking/api_service.dart';
// import 'package:vibe_in/core/networking/api_error_model.dart';
// import 'package:vibe_in/features/auth/login/data/models/login_request_body.dart';
// import 'package:vibe_in/features/auth/login/data/repo/login_repo.dart';
// import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';
// import 'package:vibe_in/features/auth/login/cubit/login_state.dart';

// void main() {
//   // TestWidgetsFlutterBinding.ensureInitialized();
//   // ✅ هذا يسمح بطباعة الـ print في الاختبارات
//   debugPrint = (String? message, {int? wrapWidth}) {
//     if (message != null) print(message);
//   };
//   late HttpServer server;
//   late Dio dio;
//   late ApiService apiService;
//   late LoginRepo loginRepo;
//   late LoginCubit loginCubit;

//   setUpAll(() async {
//     server = await shelf_io.serve(
//       dynamicMockHandler,
//       InternetAddress.anyIPv4,
//       8080,
//     );
//     await Future.delayed(Duration(milliseconds: 100)); // تأخير قصير
//     print('✅ Mock server running on: ${server.address}:${server.port}');
//     print('🔌 Test URL: http://127.0.0.1:${server.port}/mobile/send-otp');

//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'http://127.0.0.1:${server.port}',
//         connectTimeout: Duration(seconds: 2),
//         receiveTimeout: Duration(seconds: 2),
//         validateStatus: (_) => true, // <-- ✅ مهم جدًا للاختبارات
//       ),
//     );
//     dio.interceptors.add(
//       LogInterceptor(
//         request: true,
//         requestBody: true,
//         responseBody: true,
//         error: true,
//       ),
//     );
//     apiService = ApiService(dio);
//     loginRepo = LoginRepo(apiService);
//   });

//   tearDownAll(() async {
//     await server.close(force: true);
//   });

//   setUp(() {
//     loginCubit = LoginCubit(loginRepo);
//   });

//   tearDown(() {
//     loginCubit.close();
//     responseQueue.clear(); // ضروري تنظفها كل مرة
//   });

//   // test(
//   //   '✅ emits [LoadingLoginState, ErrorLoginState] when server returns 400',
//   //   () {
//   //       responseQueue.add(
//   //       shelf.Response.ok(
//   //         jsonEncode({
//   //           'status': true,
//   //           'code': 200,
//   //           'message': 'OTP sent successfully',
//   //           'data': {'otp': '1234'},
//   //         }),
//   //         headers: {'Content-Type': 'application/json'},
//   //       ),
//   //     );
//   //     loginCubit.phoneController.text = 'any';
//   //     expectLater(
//   //       loginCubit.stream,
//   //       emitsInOrder([
//   //         isA<LoadingLoginState>(),
//   //         // isA<ErrorLoginState>(),
//   //         isA<SuccessLoginState>().having(
//   //           (s) => s.loginResponse.data?.otp,
//   //           'otp',
//   //           '1234',
//   //         ),
//   //       ]),
//   //     );
//   //   },
//   // );

//   blocTest<LoginCubit, LoginState>(
//     '✅ emits [LoadingLoginState, SuccessLoginState] when server returns 200',

//     build: () {
//       responseQueue.add(
//         shelf.Response.ok(
//           jsonEncode({
//             'status': true,
//             'code': 200,
//             'message': 'OTP sent successfully',
//             'data': {'otp': '1234'},
//           }),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//           },
//         ),
//       );

//       // loginCubit.phoneController.text = '597232447';
//       // print(loginCubit.phoneController.text);
//       return loginCubit;
//     },
//     act: (cubit) {
//       cubit.phoneController.text = '512345678';
//       return cubit.emitLoginStates();
//     },
//     expect:
//         () => [
//           isA<LoadingLoginState>(),
//           isA<SuccessLoginState>().having(
//             (s) => s.loginResponse.data?.otp,
//             'otp',
//             '1234',
//           ),
//         ],
//   );

//   // blocTest<LoginCubit, LoginState>(
//   //   '🚫 emits [LoadingLoginState, ErrorLoginState] when phone is missing',
//   //   build: () {
//   //     // shelf.Response.ok(
//   //     //   jsonEncode({
//   //     //     'status': false,
//   //     //     'code': 422,
//   //     //     'message': 'Phone is required',
//   //     //     'data': {
//   //     //       'phone': ['Phone is required'],
//   //     //     },
//   //     //   }),
//   //     //   headers: {'Content-Type': 'application/json'},
//   //     // );
//   //     responseQueue.add(
//   //       shelf.Response(
//   //         422,
//   //         body: jsonEncode({
//   //           'status': false,
//   //           'code': 422,
//   //           'message': 'Phone is required',
//   //           'data': {
//   //             'phone': ['Phone is required'],
//   //           },
//   //         }),
//   //         headers: {'Content-Type': 'application/json'},
//   //       ),
//   //     );

//   //     loginCubit.phoneController.text = '';
//   //     return loginCubit;
//   //   },
//   //   act: (cubit) => cubit.emitLoginStates(),
//   //   expect:
//   //       () => [
//   //         isA<LoadingLoginState>(),
//   //         isA<ErrorLoginState>().having(
//   //           (s) => s.error,
//   //           'message',
//   //           contains('Phone is required'),
//   //         ),
//   //       ],
//   // );

//   // blocTest<LoginCubit, LoginState>(
//   //   '💥 emits [LoadingLoginState, ErrorLoginState] when server returns 500',
//   //   build: () {
//   //     responseQueue.add(
//   //       shelf.Response(
//   //         500,
//   //         body: jsonEncode({
//   //           'status': false,
//   //           'code': 500,
//   //           'message': 'Internal server error',
//   //         }),
//   //         headers: {'Content-Type': 'application/json'},
//   //       ),
//   //     );

//   //     loginCubit.phoneController.text = 'any';
//   //     return loginCubit;
//   //   },
//   //   act: (cubit) => cubit.emitLoginStates(),
//   //   expect:
//   //       () => [
//   //         isA<LoadingLoginState>(),
//   //         isA<ErrorLoginState>().having(
//   //           (s) => s.error?.toLowerCase(),
//   //           'message',
//   //           contains('internal'),
//   //         ),
//   //       ],
//   // );
// }

//! ----------------------------------------------------------------------------

// //!-------- First main test
// void main() {
//   late HttpServer server;
//   late Dio dio;
//   late ApiService apiService;
//   late LoginRepo loginRepo;
//   late LoginCubit loginCubit;

//   setUpAll(() async {
//     server = await shelf_io.serve(mockDispatcherHandler, 'localhost', 8080);
//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'http://localhost:8080',
//         validateStatus: (_) => true,
//       ),
//     );
//     apiService = ApiService(dio);
//     loginRepo = LoginRepo(apiService);
//     loginCubit = LoginCubit(loginRepo);
//   });

//   tearDownAll(() async {
//     await server.close(force: true);
//   });

//   group('Login', () {
//     test('returns OTP when phone is valid', () async {
//       LoginRequestBody loginRequestBody = LoginRequestBody(phone: '512345678');

//       final response = await dio.post(
//         '/login',
//         data: loginRequestBody.toJson(),
//       );
//       print(response.data);
//       expect(response.statusCode, 200);
//       final loginResponse = LoginResponse.fromJson(response.data);
//       expect(loginResponse, isA<LoginResponse>());
//       expect(loginResponse.data?.otp, '1234');
//     });

//     test('returns error when phone is invalid', () async {
//       LoginRequestBody loginRequestBody = LoginRequestBody(phone: '000000000');

//       dio.options.validateStatus =
//           (_) => true; // مهم لكي لا يرمي Dio استثناء على 422

//       final response = await dio.post(
//         '/login',
//         data: loginRequestBody.toJson(),
//       );

//       expect(response.statusCode, 422);
//       final error = ApiErrorModel.fromJson(response.data);
//       expect(error.message, contains('The phone field format is invalid.'));
//       expect(error.data['phone'][0], 'The phone field format is invalid.');
//       // expect(
//       //   response.data['message'],
//       //   contains('The phone field format is invalid.'),
//       // );
//       // expect(
//       //   response.data['data']['phone'][0],
//       //   'The phone field format is invalid.',
//       // );
//     });

//     test('returns error when phone is missing', () async {
//       dio.options.validateStatus = (_) => true;

//       final response = await dio.post('/login', data: {}); // بدون phone

//       expect(response.statusCode, 422);

//       final error = ApiErrorModel.fromJson(response.data);

//       expect(error.message, contains('Phone is required'));
//       expect(error.data['phone'][0], 'Phone is required');
//     });

//     test('returns 400 when malformed JSON is sent', () async {
//       dio.options.validateStatus = (_) => true;

//       final response = await dio.post(
//         '/login',
//         data: 'not-a-json',
//         options: Options(headers: {'Content-Type': 'application/json'}),
//       );

//       expect(response.statusCode, 400);

//       final error = ApiErrorModel.fromJson(response.data);

//       expect(error.message, contains('Malformed JSON'));
//     });

//     test('simulates timeout when phone is "timeout"', () async {
//       dio.options
//         ..sendTimeout = const Duration(seconds: 1)
//         ..receiveTimeout = const Duration(seconds: 1)
//         ..validateStatus = (_) => true;

//       try {
//         await dio.post('/login', data: {'phone': 'timeout'});
//         fail('Expected DioException due to timeout');
//       } on DioException catch (e) {
//         expect(e.type, DioExceptionType.receiveTimeout);
//       }
//     });

//     test('returns 404 when method is not supported', () async {
//       dio.options.validateStatus = (_) => true;

//       final response = await dio.get('/login');

//       expect(response.statusCode, 404);
//     });
//   });
// }
// ////////
// import 'dart:convert';
// import 'package:shelf/shelf.dart' as shelf;
// import 'package:vibe_in/core/networking/api_error_model.dart';
// import 'package:vibe_in/features/auth/login/data/models/login_response.dart';
// import 'package:vibe_in/features/auth/verification/data/model/verification_response.dart'
//     as verification;

// /// Dispatcher-style handler to route based on request path and method
// Future<shelf.Response> mockDispatcherHandler(shelf.Request request) async {
//   final path = request.url.path;
//   final method = request.method;

//   if (method == 'POST' && path == 'login') {
//     return _handleLogin(request);
//   } else if (method == 'POST' && path == 'verify') {
//     return _handleVerify(request);
//   }
//   // else if (method == 'GET' && path == 'profile') {
//   //   return _handleProfile(request);
//   // }

//   return shelf.Response.notFound(jsonEncode({'message': 'Route not found'}));
// }

// Future<shelf.Response> _handleLogin(shelf.Request request) async {
//   final payload = await request.readAsString();
//   final body = _tryParseJson(payload);
//   if (body == null) {
//     return _errorResponse(400, 'Malformed JSON', null);
//   }

//   final phone = body['phone'];

//   if (phone == null) {
//     return _errorResponse(422, 'Phone is required', {
//       'phone': ['Phone is required'],
//     });
//   }

//   if (phone == '512345678') {
//     // return _successResponse({
//     //   'status': true,
//     //   'code': 200,
//     //   'message': 'OTP sent to login',
//     //   'data': {'otp': '1234'},
//     // });
//     final response = LoginResponse(
//       data: Data(otp: '1234'),
//       message: 'Login successful',
//       status: true,
//       code: 200,
//     );
//     return _successResponse(response.toJson());
//   } else if (phone == 'timeout') {
//     await Future.delayed(Duration(seconds: 5));
//   }

//   return _errorResponse(422, 'The phone field format is invalid.', {
//     'phone': ['The phone field format is invalid.'],
//   });
// }

// Future<shelf.Response> _handleVerify(shelf.Request request) async {
//   final payload = await request.readAsString();
//   final body = _tryParseJson(payload);
//   if (body == null) {
//     return _errorResponse(400, 'Malformed JSON', null);
//   }
//   final otp = body['otp'];
//   if (otp == '1234') {
//     // return _successResponse({
//     //   'status': true,
//     //   'code': 200,
//     //   'message': 'OTP verified successfully',
//     //   'data': {'token': 'fake_token_abc123'},
//     // });
//     final verification.VerificationResponse response =
//         verification.VerificationResponse(
//           status: true,
//           code: 200,
//           message: 'OTP verified successfully',
//           data: verification.Data(
//             token: 'fake_token_abc123',
//             user: verification.User(
//               id: 1,
//               email: 'hassan@example.com',
//               name: 'Hassan',
//               numberId: '123456789',
//               phone: '512345678',
//               gender: 'male',
//               avatar: 'https://example.com/avatar.png',
//               profileStatus: 1,
//               city: verification.City(id: 99, city: 'Gaza'),
//             ),
//           ),
//         );
//     return _successResponse(response.toJson());
//   }

//   return _errorResponse(401, 'Invalid OTP', {
//     'otp': ['Invalid or expired OTP'],
//   });
// }

// // Future<shelf.Response> _handleProfile(shelf.Request request) async {
// //   return _successResponse({
// //     'status': true,
// //     'code': 200,
// //     'message': 'Profile loaded',
// //     'data': {
// //       'name': 'Hassan',
// //       'email': 'hassan@example.com',
// //       'avatar': 'https://example.com/avatar.png',
// //     },
// //   });
// // }

// Map<String, dynamic>? _tryParseJson(String payload) {
//   try {
//     return jsonDecode(payload);
//   } catch (_) {
//     return null;
//   }
// }

// shelf.Response _successResponse(Map<String, dynamic> data) {
//   return shelf.Response.ok(
//     jsonEncode(data),
//     headers: {'Content-Type': 'application/json'},
//   );
// }

// shelf.Response _errorResponse(
//   int code,
//   String message,
//   Map<String, dynamic>? errors,
// ) {
//   final error = ApiErrorModel(
//     status: false,
//     code: code,
//     message: message,
//     data: errors,
//   );
//   return shelf.Response(
//     code,
//     body: jsonEncode(error.toJson()),
//     // body: jsonEncode({
//     //   'status': false,
//     //   'code': code,
//     //   'message': message,
//     //   'data': errors,
//     // }),
//     headers: {'Content-Type': 'application/json'},
//   );
// }

//!----------------------------------------------------------

// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:vibe_in/core/networking/api_result.dart';
// import 'package:vibe_in/features/auth/login/data/models/login_request_body.dart';
// import 'package:vibe_in/features/auth/login/data/models/login_response.dart';
// import 'package:vibe_in/features/auth/login/data/repo/login_repo.dart';

// import 'login_cubit_test.dart';

// void main() {
//   //! MOCKING API SERVICE
//   late MockApiService mockApiService;
//   late LoginRepo loginRepo;
//   setUpAll(() {
//     registerFallbackValue(FakeLoginRequestBody());
//   });
//   setUp(() {
//     mockApiService = MockApiService();
//     loginRepo = LoginRepo(mockApiService);
//   });

//   group('LoginRepo', () {
//     const phone = '512345678';
//     final requestBody = LoginRequestBody(phone: phone);
//     final loginResponse = LoginResponse(
//       status: true,
//       message: 'Success',
//       code: 200,
//       data: Data(otp: '1234'),
//     );

//     test('returns success when API call succeeds', () async {
//       when(
//         () => mockApiService.login(requestBody),
//       ).thenAnswer((_) async => loginResponse);

//       final result = await loginRepo.login(requestBody);
//       expect(result, isA<ApiResult<LoginResponse>>());
//       expect(result.isSuccess, isTrue);
//       expect(result.data?.data?.otp, equals('1234'));
//     });

//     test('returns failure when API returns error with message', () async {
//       when(() => mockApiService.login(any())).thenThrow(
//         DioException(
//           requestOptions: RequestOptions(path: '/login'),
//           response: Response(
//             statusCode: 422,
//             requestOptions: RequestOptions(path: '/login'),
//             data: {
//               'status': false,
//               'code': 422,
//               'message': 'Invalid phone number',
//               'data': {
//                 'phone': ['Invalid phone number'],
//               },
//             },
//           ),
//           type: DioExceptionType.badResponse,
//         ),
//       );

//       final result = await loginRepo.login(requestBody);

//       expect(result.isFailure, isTrue);
//       expect(
//         result.errorHandler?.getAllErrorMessages(),
//         contains('Invalid phone number'),
//       );
//     });
//     test('returns failure when API returns error with message', () async {
//       when(() => mockApiService.login(any())).thenThrow(
//         DioException(
//           requestOptions: RequestOptions(path: '/login'),
//           response: Response(
//             statusCode: 422,
//             requestOptions: RequestOptions(path: '/login'),
//             data: {
//               'status': false,
//               'code': 422,
//               'message': 'Invalid phone number',
//               'data': {
//                 'phone': ['Invalid phone number'],
//               },
//             },
//           ),
//           type: DioExceptionType.badResponse,
//         ),
//       );

//       final result = await loginRepo.login(requestBody);

//       expect(result.isFailure, isTrue);
//       expect(
//         result.errorHandler?.getAllErrorMessages(),
//         contains('Invalid phone number'),
//       );
//     });
//     test('returns failure when API returns error without message', () async {
//       when(() => mockApiService.login(any())).thenThrow(
//         DioException(
//           requestOptions: RequestOptions(path: '/login'),
//           response: Response(
//             statusCode: 500,
//             requestOptions: RequestOptions(path: '/login'),
//             data: {},
//           ),
//           type: DioExceptionType.badResponse,
//         ),
//       );

//       final result = await loginRepo.login(requestBody);

//       expect(result.isFailure, isTrue);
//       // expect(
//       //   result.errorHandler?.getAllErrorMessages().toLowerCase(),
//       //   contains('something went wrong'),
//       // );
//     });
//     test('returns failure when Dio throws a timeout exception', () async {
//       when(() => mockApiService.login(any())).thenThrow(
//         DioException(
//           requestOptions: RequestOptions(path: '/login'),
//           type: DioExceptionType.connectionTimeout,
//         ),
//       );

//       final result = await loginRepo.login(requestBody);

//       expect(result.isFailure, isTrue);
//       expect(
//         result.errorHandler?.getAllErrorMessages().toLowerCase(),
//         contains('timeout'),
//       );
//     });
//   });
// }

// //!------------------------------------------------------------
// import 'dart:collection';
// import 'dart:convert';
// import 'package:shelf/shelf.dart' as shelf;

// /// قائمة ديناميكية من الردود لكل اختبار
// final Queue<shelf.Response> responseQueue = Queue();

// /// السيرفر يستخدم أول رد موجود في الـ queue
// // Future<shelf.Response> dynamicMockHandler(shelf.Request request) async {
// //     print('📡 Received request: ${request.method} ${request.requestedUri}');

// //   if (responseQueue.isNotEmpty) {
// //     return responseQueue.removeFirst();
// //   }

// //   return shelf.Response.internalServerError(
// //     body: jsonEncode({
// //       'status': false,
// //       'code': 500,
// //       'message': 'No mock response queued',
// //     }),
// //     headers: {'Content-Type': 'application/json'},
// //   );
// // }

// Future<shelf.Response> dynamicMockHandler(shelf.Request request) async {
//   print(
//     '📡 Received ${request.method} request to ${request.requestedUri.path}',
//   );

//   if (request.method == 'POST' &&
//       request.requestedUri.path == '/mobile/send-otp') {
//     final body = await request.readAsString();
//     print('📦 Request body: $body');

//     if (responseQueue.isEmpty) {
//       return shelf.Response.internalServerError(
//         body: jsonEncode({'error': 'No mock response configured'}),
//       );
//     }

//     return responseQueue.removeFirst();
//   }

//   return shelf.Response.notFound('Not Found');
// }
void main() {}



// import 'package:bloc_test/bloc_test.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:vibe_in/core/networking/api_error_model.dart';
// import 'package:vibe_in/core/networking/api_result.dart';
// import 'package:vibe_in/core/networking/api_service.dart';
// import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';
// import 'package:vibe_in/features/auth/login/cubit/login_state.dart';
// import 'package:vibe_in/features/auth/login/data/models/login_request_body.dart';
// import 'package:vibe_in/features/auth/login/data/models/login_response.dart';
// import 'package:vibe_in/features/auth/login/data/repo/login_repo.dart';

// // build => Returns a copy of the cubit and prepares the environment for it (such as mock rep or settings)
// // when => Returns a copy of the cubit and prepares the environment for it (such as mock rep or settings)
// // act => Runs the cubit's logic
// // expect => Asserts that the cubit's state is equal to the expected state
// // verify => Asserts that the mock repository was called
// // wait => Waits for the cubit to emit a specific state
// // seed => Sets the initial state of the cubit

// class MockLoginRepo extends Mock implements LoginRepo {}

// class FakeLoginRequestBody extends Fake implements LoginRequestBody {}

// // 🧪 Fake ApiErrorModel with message override
// class FakeApiErrorModel extends Fake implements ApiErrorModel {
//   @override
//   final dynamic data;
//   FakeApiErrorModel(this.data);

//   @override
//   String getAllErrorMessages() => data.toString();
// }

// class MockApiService extends Mock implements ApiService {}

// void main() {
//   // late MockLoginRepo mockLoginRepo;
//   // late LoginCubit loginCubit;

//   // setUpAll(() {
//   //   registerFallbackValue(FakeLoginRequestBody());
//   // });

//   // setUp(() {
//   //   mockLoginRepo = MockLoginRepo();
//   //   loginCubit = LoginCubit(mockLoginRepo);
//   // });
//   // group('LoginCubit', () {
//   //   const phone = '512345678';
//   //   // final requestBody = LoginRequestBody(phone: phone);
//   //   final loginResponse = LoginResponse(
//   //     status: true,
//   //     message: 'Success',
//   //     code: 200,
//   //     data: Data(otp: '1234'),
//   //   );

//   //   test('initial state is LoginInitial', () {
//   //     expect(loginCubit.state, isA<LoginInitial>());
//   //   });

//   //   blocTest<LoginCubit, LoginState>(
//   //     'emits [LoadingLoginState, SuccessLoginState] when login is successful',
//   //     build: () {
//   //       when(
//   //         () => mockLoginRepo.login(any(that: isA<LoginRequestBody>())),
//   //       ).thenAnswer((_) async => ApiResult.success(loginResponse));
//   //       loginCubit.phoneController.text = phone;
//   //       return loginCubit;
//   //     },
//   //     // This is the actual step that takes place inside the qubit.
//   //     // It calls emitLoginStates(), which contains the logic for connecting to the API and updating the state.
//   //     act: (cubit) => cubit.emitLoginStates(),
//   //     expect:
//   //         () => [
//   //           isA<LoadingLoginState>(),
//   //           isA<SuccessLoginState>().having(
//   //             (s) => s.loginResponse.data?.otp,
//   //             'otp',
//   //             '1234',
//   //           ),
//   //         ],
//   //   );
//   //   blocTest<LoginCubit, LoginState>(
//   //     'emits [LoadingLoginState, ErrorLoginState] when login fails',
//   //     build: () {
//   //       when(
//   //         () => mockLoginRepo.login(any(that: isA<LoginRequestBody>())),
//   //       ).thenAnswer(
//   //         (_) async =>
//   //             ApiResult.failure(FakeApiErrorModel('Invalid phone number')),
//   //       );
//   //       loginCubit.phoneController.text = phone;
//   //       return loginCubit;
//   //     },
//   //     act: (cubit) => cubit.emitLoginStates(),
//   //     expect:
//   //         () => [
//   //           isA<LoadingLoginState>(),
//   //           isA<ErrorLoginState>().having(
//   //             (s) => s.error,
//   //             'error',
//   //             'Invalid phone number',
//   //           ),
//   //         ],
//   //   );
//   // });
  
// }

