import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vibe_in/bloc_observer.dart';
import 'package:vibe_in/core/di/dependency_injection.dart';
import 'package:vibe_in/core/helpers/app_logger.dart';
import 'package:vibe_in/core/helpers/constants.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/shared_pref_helper.dart';
import 'package:vibe_in/core/routing/app_router.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/vibe_in_app.dart';

// dart run build_runner build  --delete-conflicting-outputs
Future<void> main({String? initialRouteOverride}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Future.wait<void>([
    // ScreenUtil.ensureScreenSize(),
    EasyLocalization.ensureInitialized(),
    setupGetIt(),
    SharedPrefHelper().initSharedPreference(),
  ]);
  await checkIfLoggedInUser();
  final String initialRoute = await _determineInitialRoute();
  Bloc.observer = MyBlocObserver();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder:
          (context) => EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('ar')],
            path: 'assets/translations',
            fallbackLocale: const Locale('en'),
            startLocale: const Locale('en'), // Default language
            child: VibeInApp(
              appRouter: AppRouter(),
              initialRoute: initialRouteOverride ?? initialRoute,
            ),
          ),
    ),
  );
}

checkIfLoggedInUser() async {
  String? userToken = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );
  AppLogger.info('userToken');
  AppLogger.info(userToken.toString());
  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}

Future<String> _determineInitialRoute() async {
  if (isLoggedInUser) {
    return Routes.homeScreen;
  }
  final hasSeenOnBoarding = await SharedPrefHelper().getBool(
    SharedPrefKeys.onBoardingSeen,
  );
  log(hasSeenOnBoarding.toString());
  return hasSeenOnBoarding ? Routes.loginScreen : Routes.onboardingScreen;
}
