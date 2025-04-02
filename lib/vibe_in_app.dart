import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/routing/app_router.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/theme.dart';

class VibeInApp extends StatelessWidget {
  final AppRouter appRouter;
  const VibeInApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Vibe In App',
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.homeScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
