import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_size.dart';

class CustomPngImage extends StatelessWidget {
  final String imageName;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;

  const CustomPngImage({
    Key? key,
    required this.imageName,
    this.height,
    this.width,
    this.color,
    this.fit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.png',
      height: context.setHeight(height ?? AppSize.s30),
      width: context.setWidth(width ?? AppSize.s30),
      fit: fit ?? BoxFit.cover,
      color: color,
    );
  }
}

class CustomSvgImage extends StatelessWidget {
  final String imageName;
  final double? height;
  final double? width;
  final Color? color;
  final VoidCallback? onTap;
  final int rotateAngle;
  final BoxFit? fit;

  const CustomSvgImage({
    Key? key,
    required this.imageName,
    this.height,
    this.width,
    this.color,
    this.onTap,
    this.rotateAngle = 0,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget svgImage = SvgPicture.asset(
      'assets/svgs/$imageName.svg',
      color: color,
      height: context.setHeight(height ?? AppSize.s30),
      width: context.setWidth(width ?? AppSize.s30),
      fit: fit ?? BoxFit.contain,
    );

    // Wrap with RotatedBox if needed
    if (rotateAngle != 0) {
      svgImage = RotatedBox(quarterTurns: rotateAngle, child: svgImage);
    }

    // Wrap with GestureDetector if onTap provided
    return onTap != null
        ? GestureDetector(onTap: onTap, child: svgImage)
        : svgImage;
  }
}
