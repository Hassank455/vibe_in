import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class ItemProductsOrderDetailsWidget extends StatelessWidget {
  const ItemProductsOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: context.setWidth(AppSize.s100),
          height: context.setHeight(AppSize.s106),
          padding: EdgeInsets.symmetric(
            horizontal: context.setWidth(AppSize.s12),
            vertical: context.setHeight(AppSize.s16),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s6)),
            color: AppColors.textFiledBackground,
          ),
          child: CustomCachedNetworkImage(
            urlImage:
                'https://chickchack.s3.eu-west-2.amazonaws.com/customer-dashboard/1744786351349Rectangle_39_1_.png',
            height: context.setHeight(AppSize.s146),
            width: context.setWidth(AppSize.s146),
            fit: BoxFit.contain,
          ),
        ),
        horizontalSpace(context, AppSize.s10),
        SizedBox(
          width: context.setWidth(AppSize.s150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Brilliance Yumberry Red Natural',
                maxLines: 2,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              verticalSpace(context, AppSize.s4),
              CustomText(
                text: 'Dolce Gusto',
                maxLines: 1,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
              ),
              verticalSpace(context, AppSize.s4),
              CustomText(
                text: '30.0\$',
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.mainBrown,
                  fontSize: context.setSp(AppSize.s16),
                ),
              ),
              verticalSpace(context, AppSize.s4),
              CustomText(
                text: '${AppStrings.quantity.tr()}: X2',
                maxLines: 1,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
