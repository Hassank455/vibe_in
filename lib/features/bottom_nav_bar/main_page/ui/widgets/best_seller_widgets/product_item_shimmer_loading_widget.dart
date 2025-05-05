import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';

class ProductItemShimmerLoadingWidget extends StatelessWidget {
  const ProductItemShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s320.h,
      width: AppSize.s168.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: AppSize.s220.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).cardColor
                      : AppColors.textFiledBackground,
              borderRadius: BorderRadius.circular(AppSize.s8.r),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: AppSize.s146.h,
                  width: AppSize.s146.w,
                  child: CustomShimmerWidget(
                    width: AppSize.s146.w,
                    height: AppSize.s146.h,
                    radius: AppSize.s5.r,
                  ),
                ),
                PositionedDirectional(
                  top: AppSize.s5.h,
                  end: AppSize.s5.w,
                  child: CustomShimmerWidget(
                    width: AppSize.s60.w,
                    height: AppSize.s18.h,
                    radius: AppSize.s4.r,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(AppSize.s4.h),
          CustomShimmerWidget(width: AppSize.s80.w, height: AppSize.s18.h),
          verticalSpace(AppSize.s2.h),
          CustomShimmerWidget(width: AppSize.s120.w, height: AppSize.s18.h),
          verticalSpace(AppSize.s12.h),
          CustomShimmerWidget(
            width: double.infinity,
            height: AppSize.s34.h,
            radius: AppSize.s20.r,
          ),
        ],
      ),
    );
  }
}
