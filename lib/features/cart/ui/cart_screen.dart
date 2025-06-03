import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/cart/ui/widgets/list_view_cart_widget.dart';
import 'package:vibe_in/features/cart/ui/widgets/proceed_to_checkout_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: ProceedToCheckoutWidget() ,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppStrings.shoppingCart.tr(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: AppSize.s20.sp,
              fontWeight: FontWeightHelper.bold,
            ),
          ),
          verticalSpace(AppSize.s10),
          CustomText(
            text: '(3 ${AppStrings.items.tr()})',
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppColors.gray),
          ),
          verticalSpace(AppSize.s20),
          ListViewCartWidget(),
        ],
      ).marginSymmetric(horizontal: AppSize.s16.w),
    );
  }
}
