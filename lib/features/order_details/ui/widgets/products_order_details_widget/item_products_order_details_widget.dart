import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image_removed.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class ItemProductsOrderDetailsWidget extends StatelessWidget {
  const ItemProductsOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppSize.s100.w,
          height: AppSize.s106.h,
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.s12.w,
            vertical: AppSize.s16.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s6.r),
            color: AppColors.textFiledBackground,
          ),
          child: CustomCachedNetworkImageRemoved(
            urlImage:
                'https://chickchack.s3.eu-west-2.amazonaws.com/customer-dashboard/1744786351349Rectangle_39_1_.png',
            height: AppSize.s146.h,
            width: AppSize.s146.w,
            fit: BoxFit.contain,
            borderNumber: AppSize.s1.r,
          ),
        ),
        horizontalSpaceRemoved(AppSize.s10),
        SizedBox(
          width: AppSize.s150.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Brilliance Yumberry Red Natural',
                maxLines: 2,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              verticalSpaceRemoved(AppSize.s4),
              CustomText(
                text: 'Dolce Gusto',
                maxLines: 1,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
              ),
              verticalSpaceRemoved(AppSize.s4),
              CustomText(
                text: '30.0\$',
                maxLines: 1,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.mainBrown,
                  fontSize: AppSize.s16.sp,
                ),
              ),
              verticalSpaceRemoved(AppSize.s4),
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
