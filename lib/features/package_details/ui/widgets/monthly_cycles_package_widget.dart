import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class MonthlyCyclesPackageWidget extends StatelessWidget {
  const MonthlyCyclesPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppStrings.numberOfMonthlyCycles.tr(),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeightHelper.medium,
            color: AppColors.gray,
          ),
        ),
        verticalSpace(AppSize.s16),
        SizedBox(
          height: AppSize.s32.h,
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: AppSize.s8.w),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s10.w,
                  vertical: AppSize.s6.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s36.r),
                  border: Border.all(
                    // color: AppColors.mainBrown,
                    color: AppColors.lightGray,
                    width: AppSize.s1.w,
                  ),
                ),
                child: CustomText(
                  text: 'One Time',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: AppSize.s12.sp,
                    // color: AppColors.mainBrown,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
