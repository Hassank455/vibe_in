import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/features/product_details/ui/widgets/add_to_cart_and_total_price_widget.dart';
import 'package:vibe_in/features/product_details/ui/widgets/description_product_details_widget.dart';
import 'package:vibe_in/features/product_details/ui/widgets/image_and_all_images_widget.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  const ProductDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(AppSize.s16)),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.setMinSize(AppSize.s15)),
          topRight: Radius.circular(context.setMinSize(AppSize.s15)),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: context.setHeight(AppSize.s5),
              width: context.setWidth(AppSize.s53),
              margin: EdgeInsets.only(
                top: context.setHeight(AppSize.s15),
                bottom: context.setHeight(AppSize.s5),
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(
                  context.setMinSize(AppSize.s2),
                ),
              ),
            ),
            ImageAndAllImagesWidget(),
            verticalSpace(context, AppSize.s20),
            DescriptionProductDetailsWidget(),
            verticalSpace(context, AppSize.s20),
            AddToCartAndTotalPriceWidget(),
            verticalSpace(context, AppSize.s20),
          ],
        ),
      ),
    );
  }
}
