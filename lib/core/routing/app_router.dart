import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/di/dependency_injection.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';
import 'package:vibe_in/features/auth/onboarding/cubit/onboarding_cubit.dart';
import 'package:vibe_in/features/auth/onboarding/ui/onboarding_screen.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_cubit.dart';
import 'package:vibe_in/features/auth/verification/ui/verification_screen.dart';
import 'package:vibe_in/features/best_seller_screen/cubit/best_seller_cubit.dart';
import 'package:vibe_in/features/best_seller_screen/ui/best_seller_screen.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/ui/home_screen.dart';
import 'package:vibe_in/features/auth/login/ui/login_screen.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_cubit.dart';
import 'package:vibe_in/features/checkout_screen/ui/checkout_screen.dart';
import 'package:vibe_in/features/order_details/ui/order_details_screen.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/cubit/orders_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/cubit/profile_cubit.dart';
import 'package:vibe_in/features/cart/ui/cart_screen.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';
import 'package:vibe_in/features/package_details/ui/package_details_screen.dart';
import 'package:vibe_in/features/packages_screen/cubit/packages_cubit.dart';
import 'package:vibe_in/features/packages_screen/ui/packages_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) => getIt<OnboardingCubit>()..getOnboardingData(),
                child: const OnboardingScreen(),
              ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<HomeCubit>()),
                  BlocProvider(
                    create:
                        (context) =>
                            getIt<MainPageCubit>()
                              ..getSliders()
                              ..getBestSellerProducts()
                              ..getPackages(),
                  ),
                  BlocProvider(
                    create:
                        (context) => getIt<ProfileCubit>()..getProfileData(),
                  ),
                  BlocProvider(
                    create:
                        (context) => getIt<ProductsCubit>()..getCategories(),
                  ),
                  BlocProvider(create: (context) => getIt<OrdersCubit>()),
                ],
                child: const HomeScreen(),
              ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<LoginCubit>(),
                child: const LoginScreen(),
              ),
        );
      case Routes.bestSellerScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<BestSellerCubit>()..refreshBestSellerProducts(),
                child: const BestSellerScreen(),
              ),
        );
      case Routes.packagesScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<PackagesCubit>()..refreshPackages(),
                child: const PackagesScreen(),
              ),
        );
      case Routes.orderDetailsScreen:
        return MaterialPageRoute(builder: (_) => const OrderDetailsScreen());
      case Routes.cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.checkoutScreen:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case Routes.packageDetailsScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<PackageDetailsCubit>()
                          ..getPackages(arguments as int),
                child: const PackageDetailsScreen(),
              ),
        );
      case Routes.verificationScreen:
        final args = arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<VerificationCubit>()
                          ..init(args!['phone'], args['code']),
                child: const VerificationScreen(),
              ),
        );
      default:
        return null;
    }
  }
}
