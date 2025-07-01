import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String urlImage;
  final double width;
  final double height;
  final bool isCircle;
  final double? borderRadius;
  final BoxFit? fit;

  const CustomCachedNetworkImage({
    super.key,
    required this.urlImage,
    required this.height,
    required this.width,
    this.isCircle = false,
    this.borderRadius,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final double w = context.setWidth(width);
    final double h = context.setHeight(height);
    final double radius = context.setMinSize(borderRadius ?? 0);
    final shape = isCircle ? BoxShape.circle : BoxShape.rectangle;

    final imageWidget = CachedNetworkImage(
      imageUrl: urlImage,
      cacheKey: urlImage,
      imageBuilder:
          (context, imageProvider) => Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              shape: shape,
              image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
              ),
            ),
          ),
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return CustomShimmerWidget(width: w, height: h, isCircle: isCircle);
      },
      errorWidget:
          (context, url, error) => Container(
            width: w,
            height: h,
            decoration: BoxDecoration(shape: shape),
            child: const SizedBox(),
          ),
    );

    return isCircle
        ? ClipOval(child: imageWidget)
        : ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: imageWidget,
        );
  }
}
