import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Widget? icon;
  final Widget? child;
  final Color backGroundColor;
  final Color? borderColor;
  final double width;
  final double height;
  final double heightContainer;
  final bool isLoading;
  final bool reverseIcon;
  final double borderRadius;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.title,
    this.icon,
    this.child,
    this.backGroundColor = AppColors.mainBrown,
    this.padding = EdgeInsets.zero,
    this.borderColor,
    this.width = double.infinity,
    this.height = AppSize.s56,
    this.heightContainer = AppSize.s56,
    this.isLoading = false,
    this.reverseIcon = false,
    this.borderRadius = AppSize.s8,
    this.textStyle,
    this.gradient,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final double responsiveWidth =
        width == double.infinity ? double.infinity : context.setWidth(width);
    final double responsiveHeight = context.setHeight(height);
    final double responsiveHeightContainer = context.setHeight(heightContainer);
    final double radius = context.setMinSize(borderRadius);

    return Container(
      height: responsiveHeightContainer,
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient != null ? null : backGroundColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: boxShadow,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          fixedSize: Size(responsiveWidth, responsiveHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderColor != null ? 1 : 0,
            ),
          ),
          shadowColor: Colors.transparent,
        ),
        child: Center(
          child: isLoading
              ? LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.white,
                  size: context.setMinSize(40),
                )
              : child ?? _buildDefaultContent(context),
        ),
      ),
    );
  }

  Widget _buildDefaultContent(BuildContext context) {
    final spacing = icon != null ? SizedBox(width: context.setWidth(15)) : const SizedBox();
    final iconWidget = icon ?? const SizedBox();

    final textWidget = CustomText(
      text: title,
      style: textStyle ??
          Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
    );

    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: reverseIcon
            ? [textWidget, spacing, iconWidget]
            : [iconWidget, spacing, textWidget],
      ),
    );
  }
}