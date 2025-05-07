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
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_list_item_widget.dart';

class BestSellerHomeWidget extends StatelessWidget {
  const BestSellerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: AppStrings.bestSeller.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontSize: AppSize.s14.sp),
            ),
            GestureDetector(
              onTap: () => context.pushNamed(Routes.bestSellerScreen),
              child: CustomText(
                text: AppStrings.seeAll.tr(),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppColors.gray),
              ),
            ),
          ],
        ).marginSymmetric(horizontal: AppSize.s16.w),
        verticalSpace(AppSize.s12.h),
        SizedBox(
          height: AppSize.s320.h,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder:
                (context, index) =>
                    ProductListItemWidget().marginOnly(end: AppSize.s11.w),
          ),
        ),
      ],
    );
  }
}
