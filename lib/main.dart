import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/bloc_observer.dart';
import 'package:vibe_in/core/di/dependency_injection.dart';
import 'package:vibe_in/core/routing/app_router.dart';
import 'package:vibe_in/vibe_in_app.dart';

// dart run build_runner build  --delete-conflicting-outputs
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait<void>([
    ScreenUtil.ensureScreenSize(),
    // EasyLocalization.ensureInitialized(),
    setupGetIt(),
    // SharedPrefHelper().initSharedPreference(),
  ]);
  Bloc.observer = MyBlocObserver();
  runApp(VibeInApp(appRouter: AppRouter()));
}