import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:vibe_in/core/networking/api_service.dart';
import 'package:vibe_in/core/networking/dio_factory.dart';
import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';
import 'package:vibe_in/features/auth/login/data/repo/login_repo.dart';
import 'package:vibe_in/features/auth/onboarding/cubit/onboarding_cubit.dart';
import 'package:vibe_in/features/auth/onboarding/data/repo/onboarding_repo.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_cubit.dart';
import 'package:vibe_in/features/auth/verification/data/repo/verification_repo.dart';
import 'package:vibe_in/features/best_seller_screen/cubit/best_seller_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/repo/main_page_repo.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/cubit/orders_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/repo/products_repo.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/cubit/profile_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/data/repo/profile_repo.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';
import 'package:vibe_in/features/package_details/data/repo/package_details_repo.dart';
import 'package:vibe_in/features/packages_screen/cubit/packages_cubit.dart';

//! important
// registerLazySingleton => create one instant and use it in all app
// registerFactory => every time we want to use it create new instant

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = await DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(dio, baseUrl: dotenv.env['API_BASE_URL_DEV']!),
  );

  // Onboarding
  getIt.registerFactory<OnboardingRepo>(() => OnboardingRepo(getIt()));
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit(getIt()));

  // login
  getIt.registerFactory<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // login
  getIt.registerFactory<VerificationRepo>(() => VerificationRepo(getIt()));
  getIt.registerFactory<VerificationCubit>(() => VerificationCubit(getIt()));

  // home
  getIt.registerFactory<HomeCubit>(() => HomeCubit());

  // Products
  getIt.registerFactory<ProductsRepo>(() => ProductsRepo(getIt()));
  getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));

  // Orders
  getIt.registerFactory<OrdersCubit>(() => OrdersCubit());

  // Profile
  getIt.registerFactory<ProfileRepo>(() => ProfileRepo(getIt()));
  getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit(getIt()));
  // Main Page
  getIt.registerFactory<MainPageRepo>(() => MainPageRepo(getIt()));
  getIt.registerLazySingleton<MainPageCubit>(() => MainPageCubit(getIt()));
  // Main Page
  getIt.registerFactory<BestSellerCubit>(() => BestSellerCubit(getIt()));

  getIt.registerFactory<PackagesCubit>(() => PackagesCubit(getIt()));

  // Package Details
  getIt.registerFactory<PackageDetailsRepo>(() => PackageDetailsRepo(getIt()));
  getIt.registerFactory<PackageDetailsCubit>(
    () => PackageDetailsCubit(getIt()),
  );
  // Product Details
  // getIt.registerFactory<ProductDetailsCubit>(() => ProductDetailsCubit());
}

// to reset di
Future<void> resetAndSetupDependencies() async {
  await getIt.reset();
  await setupGetIt();
}
