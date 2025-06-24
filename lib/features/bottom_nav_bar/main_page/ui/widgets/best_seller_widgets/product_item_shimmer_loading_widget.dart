import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';

class ProductItemShimmerLoadingWidget extends StatelessWidget {
  const ProductItemShimmerLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sizeProvider.height,
      width: context.sizeProvider.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.setHeight(AppSize.s220),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).cardColor
                  : AppColors.textFiledBackground,
              borderRadius:
                  BorderRadius.circular(context.setMinSize(AppSize.s8)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: context.setHeight(AppSize.s146),
                  width: context.setWidth(AppSize.s146),
                  child: CustomShimmerWidget(
                    width: context.setWidth(AppSize.s146),
                    height: context.setHeight(AppSize.s146),
                    radius: context.setMinSize(AppSize.s5),
                  ),
                ),
                PositionedDirectional(
                  top: context.setHeight(AppSize.s5),
                  end: context.setWidth(AppSize.s5),
                  child: CustomShimmerWidget(
                    width: context.setWidth(AppSize.s60),
                    height: context.setHeight(AppSize.s18),
                    radius: context.setMinSize(AppSize.s4),
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(context, AppSize.s4),
          CustomShimmerWidget(
            width: context.setWidth(AppSize.s80),
            height: context.setHeight(AppSize.s18),
          ),
          verticalSpace(context, AppSize.s2),
          CustomShimmerWidget(
            width: context.setWidth(AppSize.s120),
            height: context.setHeight(AppSize.s18),
          ),
          verticalSpace(context, AppSize.s12),
          CustomShimmerWidget(
            width: double.infinity,
            height: context.setHeight(AppSize.s34),
            radius: context.setMinSize(AppSize.s20),
          ),
        ],
      ),
    );
  }
}
