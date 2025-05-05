import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/helpers.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/product_details/cubit/product_details_cubit.dart';
import 'package:vibe_in/features/product_details/ui/widgets/add_to_cart_and_total_price_widget.dart';
import 'package:vibe_in/features/product_details/ui/widgets/description_product_details_widget.dart';
import 'package:vibe_in/features/product_details/ui/widgets/image_and_all_images_widget.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  const ProductDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s15.r),
          topRight: Radius.circular(AppSize.s15.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: AppSize.s5.h,
            width: AppSize.s53.w,
            margin: EdgeInsets.only(top: AppSize.s15.h, bottom: AppSize.s5.h),
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(AppSize.s2.r),
            ),
          ),
          ImageAndAllImagesWidget(),
          verticalSpace(AppSize.s20),
          DescriptionProductDetailsWidget(),
          verticalSpace(AppSize.s20),
          AddToCartAndTotalPriceWidget(),
          verticalSpace(AppSize.s20),
        ],
      ),
    );
  }
}
