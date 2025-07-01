import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';

class LoadingPackageItemWidget extends StatelessWidget {
  final double height;
  final double heightImage;
  const LoadingPackageItemWidget({
    super.key,
    this.height = AppSize.s263,
    this.heightImage = AppSize.s154,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.setHeight(height),
      width: context.sizeProvider.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.setHeight(heightImage),
            width: double.infinity,
            child: CustomShimmerWidget(
              width: double.infinity,
              height: context.setHeight(heightImage),
              radius: context.setMinSize(AppSize.s8),
            ),
          ),
          verticalSpace(context, AppSize.s9),
          CustomShimmerWidget(
            width: context.setWidth(AppSize.s200),
            height: context.setHeight(AppSize.s20),
          ),
          verticalSpace(context, AppSize.s7),
          CustomShimmerWidget(
            width: context.setWidth(AppSize.s240),
            height: context.setHeight(AppSize.s30),
          ),
          verticalSpace(context, AppSize.s7),
          CustomShimmerWidget(
            width: context.setWidth(AppSize.s80),
            height: context.setHeight(AppSize.s25),
          ),
        ],
      ),
    );
  }
}
