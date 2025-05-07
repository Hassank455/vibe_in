import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class ProceedToCheckoutWidget extends StatelessWidget {
  const ProceedToCheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: AppStrings.subtotal.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontSize: AppSize.s20.sp),
            ),
            CustomText(
              text: '100\$',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s20.sp,
                color: AppColors.mainBrown,
              ),
            ),
          ],
        ),
        verticalSpace(AppSize.s26),
        CustomElevatedButton(
          onTap: () {
            context.pushNamed(Routes.checkoutScreen);
          },
          title: AppStrings.proceedToCheckout.tr(),
        ),
        verticalSpace(AppSize.s26),
      ],
    ).marginSymmetric(horizontal: AppSize.s16.w);
  }
}
