import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_list_item_widget.dart';

class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppStrings.bestSeller.tr(),
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontSize: AppSize.s20.sp),
          ),
          verticalSpace(AppSize.s20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: AppSize.s20.h,
              crossAxisSpacing: AppSize.s27.w,
              shrinkWrap: true,
              childAspectRatio: 0.5,
              children: List.generate(
                10,
                (index) => const ProductListItemWidget(),
              ),
            ),
          ),
        ],
      ).marginSymmetric(horizontal: AppSize.s16.w),
    );
  }
}
