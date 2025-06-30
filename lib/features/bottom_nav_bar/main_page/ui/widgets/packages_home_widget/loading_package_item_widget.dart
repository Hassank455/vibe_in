import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';

class LoadingPackageItemWidget extends StatelessWidget {
  final double height;
  final double heightImage;
  const LoadingPackageItemWidget({
    super.key,
    this.height = AppSize.s263,
    this.heightImage = AppSize.s154,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: AppSize.s284.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: heightImage.h,
            width: double.infinity,
            child: CustomShimmerWidget(
              width: double.infinity,
              height: heightImage.h,
              radius: AppSize.s8.r,
            ),
          ),
          verticalSpace(AppSize.s9),
          CustomShimmerWidget(width: AppSize.s200.w, height: AppSize.s20.h),
          verticalSpace(AppSize.s7),
          CustomShimmerWidget(width: AppSize.s240.w, height: AppSize.s30.h),
          verticalSpace(AppSize.s7),
          CustomShimmerWidget(width: AppSize.s80.w, height: AppSize.s25.h),
        ],
      ),
    );
  }
}
