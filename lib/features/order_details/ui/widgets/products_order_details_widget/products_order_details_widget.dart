import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/order_details/ui/widgets/products_order_details_widget/item_products_order_details_widget.dart';

class ProductsOrderDetailsWidget extends StatelessWidget {
  const ProductsOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: '${AppStrings.products.tr()} (2)',
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeightHelper.bold),
        ),
        verticalSpace(context, AppSize.s20),
        ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder:
              (context, index) => ItemProductsOrderDetailsWidget().marginOnly(
                bottom: context.setHeight(AppSize.s20),
              ),
        ),
      ],
    );
  }
}
