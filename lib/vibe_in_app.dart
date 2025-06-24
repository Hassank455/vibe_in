import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
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
    return SizeProvider(
      baseSize: Size(393, 852),
      width: context.screenWidth,
      height: context.screenHeight,
      child: Builder(
        // 💡 مهم جدًا
        builder:
            (context) => MaterialApp(
              title: 'Vibe In App',
              theme: Themes.light(context),
              darkTheme: Themes.dark(context),
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              initialRoute: initialRoute,
              // initialRoute: Routes.onboardingScreen,
              onGenerateRoute: appRouter.generateRoute,
            ),
      ),
    );
  }
}
