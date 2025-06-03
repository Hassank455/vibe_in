import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';

// ignore: must_be_immutable
class CustomCachedNetworkImage extends StatelessWidget {
  final String urlImage;
  final double width;
  final double height;
  final double borderNumber;
  final BoxFit? fit;

  const CustomCachedNetworkImage({
    required this.urlImage,
    required this.height,
    required this.width,
    required this.borderNumber,
    super.key,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderNumber.r),
      child: CachedNetworkImage(
        imageUrl: urlImage,
        cacheKey: urlImage,
        imageBuilder:
            (context, imageProvider) => Container(
              width: ScreenUtil().setWidth(width),
              height: ScreenUtil().setHeight(height),
              decoration: BoxDecoration(
                shape: borderNumber == 0 ? BoxShape.circle : BoxShape.rectangle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit ?? BoxFit.cover,
                ),
              ),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return CustomShimmerWidget(
            width: width.w,
            height: height.h,
            isCircle: borderNumber == 0 ? true : false,
          );
        },
        errorWidget:
            (context, url, error) => Container(
              width: ScreenUtil().setWidth(width),
              height: ScreenUtil().setHeight(height),
              decoration: BoxDecoration(
                shape: borderNumber == 0 ? BoxShape.circle : BoxShape.rectangle,
              ),
              child: const SizedBox(),
            ),
      ),
    );
  }
}
