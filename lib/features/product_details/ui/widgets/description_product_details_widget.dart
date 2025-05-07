import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/product_details/ui/widgets/quantity_increase_dicrease_widget.dart';

class DescriptionProductDetailsWidget extends StatelessWidget {
  const DescriptionProductDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Brilliance Yumberry Red Natural',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  verticalSpace(AppSize.s6),
                  CustomText(
                    text: 'Dolce Gusto',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                QuantityIncreaseDecreaseWidget(
                  quantity: '1',
                  onTapIncrease: () {},
                  onTapDecrease: () {},
                  backgroundColor: AppColors.gray.withOpacity(0.1),
                ),
              ],
            ),
          ],
        ),
        verticalSpace(AppSize.s16),
        CustomText(
          text:
              'It\'s time to rethink your energy! Monin Brilliance Natural Energy combines the power of Coffeeberry® Energy, green coffee extract, L-theanine, vitamin B12, and guarana to create a delicious and clean label iced energy drink. Made with natural colors and authentic yumberry flavor, Yumberry Red delivers a brilliant red color and exotic berry taste. Each 1-oz. serving (2 pumps) of Yumberry Red contains 80mg of natural caffeine.',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
