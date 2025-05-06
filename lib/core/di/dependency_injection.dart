import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vibe_in/core/networking/api_constants.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/core/networking/dio_factory.dart';
import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';
import 'package:vibe_in/features/auth/login/data/repo/login_repo.dart';
import 'package:vibe_in/features/auth/onboarding/cubit/onboarding_cubit.dart';
import 'package:vibe_in/features/auth/onboarding/data/repo/onboarding_repo.dart';

//! important
// registerLazySingleton => create one instant and use it in all app
// registerFactory => every time we want to use it create new instant

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = await DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(dio, baseUrl: ApiConstants.apiBaseUrl),
  );

  // Onboarding
  getIt.registerFactory<OnboardingRepo>(() => OnboardingRepo(getIt()));
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit(getIt()));

  // login
  getIt.registerFactory<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // home
}
