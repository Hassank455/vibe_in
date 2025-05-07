import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/widgets/filter_bottom_sheet/item_filter_bottom_sheet.dart';

class FilterProductsBottomSheet extends StatelessWidget {
  const FilterProductsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s15.r),
          topRight: Radius.circular(AppSize.s15.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: AppSize.s5.h,
            width: AppSize.s53.w,
            margin: EdgeInsets.only(top: AppSize.s15.h, bottom: AppSize.s5.h),
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(AppSize.s2.r),
            ),
          ),
          verticalSpace(AppSize.s20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.filter.tr(),
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.copyWith(fontSize: AppSize.s20.sp),
              ),
              CustomText(
                text: AppStrings.reset.tr(),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontSize: AppSize.s12.sp),
              ),
            ],
          ),

          verticalSpace(AppSize.s30),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: AppSize.s20.h,
            crossAxisSpacing: AppSize.s7.w,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.5,
            children: List.generate(9, (index) => ItemFilterBottomSheet()),
          ),
          verticalSpace(AppSize.s40),
          CustomElevatedButton(onTap: () {}, title: AppStrings.filter.tr()),
          verticalSpace(AppSize.s40),
        ],
      ),
    );
  }
}
