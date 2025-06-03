import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class OrderListViewItemWidget extends StatelessWidget {
  const OrderListViewItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Wed 12 Mar 2025 - 11:49 AM',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeightHelper.semiBold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.s25.w,
                vertical: AppSize.s6.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightYellow,
                borderRadius: BorderRadius.circular(AppSize.s6.r),
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
        verticalSpace(AppSize.s16),
        GestureDetector(
          onTap: () {
            context.pushNamed(Routes.orderDetailsScreen);
          },
          child: Row(
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
                child: CustomCachedNetworkImage(
                  urlImage:
                      'https://chickchack.s3.eu-west-2.amazonaws.com/customer-dashboard/1744786351349Rectangle_39_1_.png',
                  height: AppSize.s146.h,
                  width: AppSize.s146.w,
                  fit: BoxFit.contain,
                  borderNumber: AppSize.s1.r,
                ),
              ),
              horizontalSpace(AppSize.s10),
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
                    verticalSpace(AppSize.s4),
                    CustomText(
                      text: 'Dolce Gusto',
                      maxLines: 1,
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                    ),
                    verticalSpace(AppSize.s4),
                    CustomText(
                      text: '30.0\$',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.mainBrown,
                        fontSize: AppSize.s16.sp,
                      ),
                    ),
                    verticalSpace(AppSize.s4),
                    CustomText(
                      text: '${AppStrings.products.tr()}: X2',
                      maxLines: 1,
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ).marginOnly(bottom: AppSize.s24.h);
  }
}
