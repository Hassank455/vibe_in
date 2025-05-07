import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';

class HeaderOrderDetailsWidget extends StatelessWidget {
  const HeaderOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppStrings.trackOrder.tr(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontSize: AppSize.s20.sp,
            fontWeight: FontWeightHelper.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.orderNumber.tr(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeightHelper.medium,
                    ),
                  ),
                  TextSpan(text: '  '),
                  TextSpan(
                    text: '#4850FE4KDW2',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.s25.w,
                vertical: AppSize.s6.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightYellow,
                borderRadius: BorderRadius.circular(AppSize.s4.r),
              ),
              child: CustomText(
                text: 'Pending',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppColors.yellow),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
