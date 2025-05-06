import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final bool isCircle;
  final double radius;
  const CustomShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.isCircle = false,
    this.radius = AppSize.s10,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDarkMode ? AppColors.darkGrey : AppColors.moreLightGrey;
    final highlightColor = isDarkMode ? AppColors.lightGrey : Colors.white;
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
