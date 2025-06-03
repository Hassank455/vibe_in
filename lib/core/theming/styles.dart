import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/constants.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';

///
/// | NAME           | SIZE |  WEIGHT |  SPACING |             |
/// |----------------|------|---------|----------|-------------|
/// | displayLarge   | 96.0 | light   | -1.5     |             |
/// | displayMedium  | 60.0 | light   | -0.5     |             |
/// | displaySmall   | 48.0 | regular |  0.0     |             |
/// | headlineMedium | 34.0 | regular |  0.25    |             |
/// | headlineSmall  | 24.0 | regular |  0.0     |             |
/// | titleLarge     | 20.0 | medium  |  0.15    |             |
/// | titleMedium    | 16.0 | regular |  0.15    |             |
/// | titleSmall     | 14.0 | medium  |  0.1     |             |
/// | bodyLarge      | 16.0 | regular |  0.5     |             |
/// | bodyMedium     | 14.0 | regular |  0.25    |             |
/// | bodySmall      | 12.0 | regular |  0.4     |             |
/// | labelLarge     | 14.0 | medium  |  1.25    |             |
/// | labelSmall     | 10.0 | regular |  1.5     |             |
///

// TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
//   return TextStyle(
//     fontSize: fontSize.sp,
//     fontFamily: SharedPrefKeys.fontFamily,
//     color: color,
//     fontWeight: fontWeight,
//   );
// }

// // regular style

// TextStyle getRegularStyle({
//   double fontSize = AppSize.s12,
//   Color color = AppColors.normalBlack,
// }) {
//   return _getTextStyle(fontSize, FontWeightHelper.regular, color);
// }

// // medium style

// TextStyle getMediumStyle({
//   double fontSize = AppSize.s14,
//   Color color = AppColors.normalBlack,
// }) {
//   return _getTextStyle(fontSize, FontWeightHelper.medium, color);
// }

// // medium style

// TextStyle getLargeStyle({
//   double fontSize = AppSize.s16,
//   Color color = AppColors.normalBlack,
// }) {
//   return _getTextStyle(fontSize, FontWeightHelper.medium, color);
// }

// // bold style

// TextStyle getBoldStyle({
//   double fontSize = AppSize.s18,
//   Color color = AppColors.normalBlack,
// }) {
//   return _getTextStyle(fontSize, FontWeightHelper.bold, color);
// }

// // semibold style

// TextStyle getSemiBoldStyle({
//   double fontSize = AppSize.s20,
//   Color color = AppColors.normalBlack,
// }) {
//   return _getTextStyle(fontSize.sp, FontWeightHelper.semiBold, color);
// }

//! NEW REFACTOR

class AppTextStyles {
  static TextStyle _baseTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return TextStyle(
      fontSize: fontSize.sp,
      fontFamily: SharedPrefKeys.fontFamily,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle regular({
    double fontSize = AppSize.s12,
    Color color = AppColors.black,
  }) => _baseTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightHelper.regular,
    color: color,
  );

  static TextStyle medium({
    double fontSize = AppSize.s14,
    Color color = AppColors.black,
  }) => _baseTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightHelper.medium,
    color: color,
  );

  static TextStyle semiBold({
    double fontSize = AppSize.s16,
    Color color = AppColors.black,
  }) => _baseTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightHelper.semiBold,
    color: color,
  );

  static TextStyle bold({
    double fontSize = AppSize.s18,
    Color color = AppColors.black,
  }) => _baseTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightHelper.bold,
    color: color,
  );
}
