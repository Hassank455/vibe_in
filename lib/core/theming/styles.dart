import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/constants.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';

class AppTextStyles {
  static TextStyle _baseTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required BuildContext context,
  }) {
    return TextStyle(
      fontSize: context.setSp(fontSize),
      fontFamily: SharedPrefKeys.fontFamily,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle regular(
    BuildContext context, {
    double fontSize = AppSize.s12,
    Color color = AppColors.black,
  }) => _baseTextStyle(
    context: context,
    fontSize: fontSize,
    fontWeight: FontWeightHelper.regular,
    color: color,
  );

  static TextStyle medium(
    BuildContext context, {
    double fontSize = AppSize.s14,
    Color color = AppColors.black,
  }) => _baseTextStyle(
    context: context,
    fontSize: fontSize,
    fontWeight: FontWeightHelper.medium,
    color: color,
  );

  static TextStyle semiBold(
    BuildContext context, {
    double fontSize = AppSize.s16,
    Color color = AppColors.black,
  }) => _baseTextStyle(
    context: context,
    fontSize: fontSize,
    fontWeight: FontWeightHelper.semiBold,
    color: color,
  );

  static TextStyle bold(
    BuildContext context, {
    double fontSize = AppSize.s18,
    Color color = AppColors.black,
  }) => _baseTextStyle(
    context: context,
    fontSize: fontSize,
    fontWeight: FontWeightHelper.bold,
    color: color,
  );
}
