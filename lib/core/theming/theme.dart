import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/styles.dart';

class Themes {
  static ThemeData light(BuildContext context) => ThemeData.light().copyWith(
    primaryColor: AppColors.mainBrown,
    scaffoldBackgroundColor: AppColors.white,
    cardColor: AppColors.white,
    textTheme: TextTheme(
      titleSmall: AppTextStyles.regular(context),
      titleMedium: AppTextStyles.medium(context),
      titleLarge: AppTextStyles.semiBold(context),
      headlineSmall: AppTextStyles.semiBold(context, fontSize: AppSize.s24),
      headlineMedium: AppTextStyles.bold(context, fontSize: AppSize.s34),
      headlineLarge: AppTextStyles.bold(context, fontSize: AppSize.s48),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.textFiledBackground,
      contentPadding: EdgeInsets.symmetric(
        vertical: context.setHeight(AppSize.s18),
        horizontal: context.setWidth(AppSize.s16),
      ),
      hintStyle: AppTextStyles.regular(context, color: AppColors.gray),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        borderSide: BorderSide(
          color: AppColors.textFiledBackground,
          width: context.setWidth(AppSize.s1),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        borderSide: BorderSide(
          color: AppColors.textFiledBackground,
          width: context.setWidth(AppSize.s1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        borderSide: BorderSide(
          color: AppColors.textFiledBackground,
          width: context.setWidth(AppSize.s1),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        borderSide: BorderSide(
          color: AppColors.failure,
          width: context.setWidth(AppSize.s1),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        borderSide: BorderSide(
          color: AppColors.textFiledBackground,
          width: context.setWidth(AppSize.s1),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: AppColors.black),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.bold(context),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.light,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.light,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.black),
  );

  static ThemeData dark(BuildContext context) => ThemeData.dark().copyWith(
    primaryColor: AppColors.mainBrown,
    scaffoldBackgroundColor: AppColors.backgroundFrame,
    cardColor: AppColors.cardDark,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: AppColors.white),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.bold(
        context,
        fontSize: AppSize.s16,
        color: AppColors.white,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Platform.isAndroid ? Brightness.light : Brightness.dark,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.light : Brightness.dark,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCardColor,
      contentPadding: EdgeInsets.symmetric(
        vertical: context.setHeight(AppSize.s18),
        horizontal: context.setWidth(AppSize.s16),
      ),
      hintStyle: AppTextStyles.regular(context, color: AppColors.white),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        borderSide: BorderSide(
          color: AppColors.darkCardColor,
          width: context.setWidth(AppSize.s1),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        borderSide: BorderSide(
          color: AppColors.darkCardColor,
          width: context.setWidth(AppSize.s1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        borderSide: BorderSide(
          color: AppColors.darkCardColor,
          width: context.setWidth(AppSize.s1),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        borderSide: BorderSide(
          color: AppColors.failure,
          width: context.setWidth(AppSize.s1),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        borderSide: BorderSide(
          color: AppColors.darkCardColor,
          width: context.setWidth(AppSize.s1),
        ),
      ),
    ),
    textTheme: TextTheme(
      titleSmall: AppTextStyles.regular(context, color: AppColors.white),
      titleMedium: AppTextStyles.medium(context, color: AppColors.white),
      titleLarge: AppTextStyles.semiBold(context, color: AppColors.white),
      headlineSmall: AppTextStyles.semiBold(
        context,
        fontSize: AppSize.s24,
        color: AppColors.white,
      ),
      headlineMedium: AppTextStyles.bold(
        context,
        fontSize: AppSize.s34,
        color: AppColors.white,
      ),
      headlineLarge: AppTextStyles.bold(
        context,
        fontSize: AppSize.s48,
        color: AppColors.white,
      ),
    ),
  );
}
