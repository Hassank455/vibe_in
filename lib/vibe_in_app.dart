import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/routing/app_router.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/theme.dart';

class VibeInApp extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;
  const VibeInApp({
    super.key,
    required this.appRouter,
    this.initialRoute = Routes.onboardingScreen, // Default
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder:
          (context, child) => MaterialApp(
            title: 'Vibe In App',
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute:  initialRoute,
            //initialRoute: Routes.homeScreen,
            onGenerateRoute: appRouter.generateRoute,
          ),
    );
  }
}
