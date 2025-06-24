import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';

class LoadingShimmerPackageDetailsWidget extends StatelessWidget {
  const LoadingShimmerPackageDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShimmerWidget(
            width: double.infinity,
            height: AppSize.s196.h,
            radius: AppSize.s8.r,
          ),
          verticalSpaceRemoved(AppSize.s16),
          CustomShimmerWidget(width: AppSize.s220.h, height: AppSize.s20.h),
          verticalSpaceRemoved(AppSize.s10),
          CustomShimmerWidget(width: AppSize.s80.h, height: AppSize.s30.h),
          verticalSpaceRemoved(AppSize.s10),
          CustomShimmerWidget(width: AppSize.s200.h, height: AppSize.s18.h),
          verticalSpaceRemoved(AppSize.s16),
          SizedBox(
            height: AppSize.s32.h,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CustomShimmerWidget(
                  width: AppSize.s75.w,
                  height: AppSize.s32.h,
                  radius: AppSize.s36.r,
                ).marginOnly(end: AppSize.s8.w);
              },
            ),
          ),
          verticalSpaceRemoved(AppSize.s20),
          CustomShimmerWidget(width: AppSize.s80.h, height: AppSize.s20.h),
          verticalSpaceRemoved(AppSize.s12),
          SizedBox(
            height: AppSize.s118.h,
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: AppSize.s80.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomShimmerWidget(
                        height: AppSize.s80.h,
                        width: AppSize.s80.w,
                        radius: AppSize.s8.r,
                      ),

                      verticalSpaceRemoved(AppSize.s4),
                      CustomShimmerWidget(
                        width: AppSize.s50.h,
                        height: AppSize.s14.h,
                      ),
                      verticalSpaceRemoved(AppSize.s4),
                      CustomShimmerWidget(
                        width: AppSize.s70.h,
                        height: AppSize.s14.h,
                      ),
                    ],
                  ).marginOnly(end: AppSize.s10.w),
                );
              },
            ),
          ),
          verticalSpaceRemoved(AppSize.s20),
          CustomShimmerWidget(width: AppSize.s80.h, height: AppSize.s20.h),
          verticalSpaceRemoved(AppSize.s12),
          CustomShimmerWidget(
            width: double.infinity,
            height: AppSize.s100.h,
            radius: AppSize.s8.r,
          ),
        ],
      ),
    );
  }
}
