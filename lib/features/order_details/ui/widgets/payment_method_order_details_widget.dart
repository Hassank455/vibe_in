import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image_removed.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class PaymentMethodOrderDetailsWidget extends StatelessWidget {
  const PaymentMethodOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppStrings.paymentMethod.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeightHelper.bold),
        ),
        verticalSpaceRemoved(AppSize.s20),
        ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          title: CustomText(
            text: 'Apple Pay',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontSize: AppSize.s12.sp),
          ),
          trailing: CustomCachedNetworkImageRemoved(
            urlImage: 'https://img.icons8.com/ios/50/000000/apple-pay.png',
            height: AppSize.s26.h,
            width: AppSize.s56.w,
            borderNumber: AppSize.s1.r,
          ),
        ),
      ],
    );
  }
}
