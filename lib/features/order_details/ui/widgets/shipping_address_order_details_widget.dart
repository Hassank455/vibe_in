import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class ShippingAddressOrderDetailsWidget extends StatelessWidget {
  const ShippingAddressOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        CustomText(
          text: AppStrings.shippingAddress.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeightHelper.bold),
        ),
        verticalSpace(context, AppSize.s20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(context.setMinSize(AppSize.s15)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.textFiledBackground,
              ),
              child: CustomSvgImage(
                imageName: AppSvgImage.location,
                width: context.setWidth(AppSize.s24),
                height: context.setHeight(AppSize.s24),
              ),
            ),
            horizontalSpace(context, AppSize.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Mohammed Al-Otaibi’s House',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  verticalSpace(context, AppSize.s6),
                  CustomText(
                    text: '+966512345678',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  verticalSpace(context, AppSize.s6),
                  CustomText(
                    text: 'Saudi Arabia',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  verticalSpace(context, AppSize.s6),
                  CustomText(
                    text: 'Riyadh',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  verticalSpace(context, AppSize.s6),
                  CustomText(
                    text:
                        'Jabal Tuwaiq Street, Villa No. 23, Al-Narjis District,  13324',
                    maxLines: 2,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
