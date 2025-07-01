import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/product_details/cubit/product_details_cubit.dart';
import 'package:vibe_in/features/product_details/cubit/product_details_state.dart';

class DescriptionProductDetailsWidget extends StatelessWidget {
  const DescriptionProductDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsCubit productDetailsCubit =
        context.read<ProductDetailsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    text: productDetailsCubit.product.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  verticalSpace(context, AppSize.s6),
                  CustomText(
                    text: productDetailsCubit.product.category!.name,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            ),
          ],
        ),
        verticalSpace(context, AppSize.s16),
        CustomText(
          text: productDetailsCubit.product.description,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        verticalSpace(context, AppSize.s16),
        CustomText(
          text: AppStrings.selectWeight.tr(),
          textAlign: TextAlign.start,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeightHelper.medium),
        ),
        verticalSpace(context, AppSize.s8),
        BlocSelector<ProductDetailsCubit, ProductDetailsState, int>(
          selector: (state) => state.selectedPriceIndex,
          builder: (context, state) {
            return SizedBox(
              height: context.setHeight(AppSize.s34),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: productDetailsCubit.product.prices!.length,
                itemBuilder: (context, index) {
                  final price = productDetailsCubit.product.prices![index];
                  final isSelected =
                      productDetailsCubit.state.selectedPriceIndex == index;
                  return GestureDetector(
                    onTap: () => productDetailsCubit.selectPriceIndex(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.setWidth(AppSize.s22),
                        vertical: context.setHeight(AppSize.s6),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              isSelected ? AppColors.mainBrown : AppColors.gray,
                          width: context.setWidth(AppSize.s1),
                        ),
                        borderRadius: BorderRadius.circular(
                          context.setMinSize(AppSize.s8),
                        ),
                      ),
                      child: CustomText(
                        text: price.weight,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeightHelper.semiBold,
                          color:
                              isSelected ? AppColors.mainBrown : AppColors.gray,
                        ),
                      ),
                    ),
                  ).marginOnly(
                    end:
                        productDetailsCubit.product.prices!.length == index + 1
                            ? context.setWidth(AppSize.s0)
                            : context.setWidth(AppSize.s13),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
