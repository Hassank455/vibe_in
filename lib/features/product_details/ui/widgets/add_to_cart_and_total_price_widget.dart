import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/helpers.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/product_details/cubit/product_details_cubit.dart';
import 'package:vibe_in/features/product_details/cubit/product_details_state.dart';

class AddToCartAndTotalPriceWidget extends StatelessWidget {
  const AddToCartAndTotalPriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsCubit productDetailsCubit =
        context.read<ProductDetailsCubit>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              CustomText(
                text: AppStrings.totalPrice.tr(),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeightHelper.medium,
                  color: AppColors.gray,
                ),
              ),
              verticalSpace(context, AppSize.s6),
              BlocSelector<ProductDetailsCubit, ProductDetailsState, int>(
                selector: (state) => state.selectedPriceIndex,

                builder: (context, state) {
                  return CustomText(
                    text:
                        '\$${productDetailsCubit.product.prices![state].price} ',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeightHelper.semiBold,
                      fontSize: context.setSp(AppSize.s18),
                      color: AppColors.mainBrown,
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        Expanded(
          flex: 5,
          child: CustomElevatedButton(
            onTap: () {
              Helper().snackBarAddToCart(context);
            },
            title: AppStrings.addToCart.tr(),
          ),
        ),
      ],
    );
  }
}
