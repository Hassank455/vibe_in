import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';

class LoadingShimmerPackageDetailsWidget extends StatelessWidget {
  const LoadingShimmerPackageDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShimmerWidget(
            width: double.infinity,
            height: context.setHeight(AppSize.s196),
            radius: context.setMinSize(AppSize.s8),
          ),
          verticalSpace(context, AppSize.s16),
          CustomShimmerWidget(
            width: context.setWidth(AppSize.s220),
            height: context.setHeight(AppSize.s20),
          ),
          verticalSpace(context, AppSize.s10),
          CustomShimmerWidget(
            width: context.setWidth(AppSize.s80),
            height: context.setHeight(AppSize.s30),
          ),
          verticalSpace(context, AppSize.s10),
          CustomShimmerWidget(
            width: context.setWidth(AppSize.s200),
            height: context.setHeight(AppSize.s18),
          ),
          verticalSpace(context, AppSize.s16),
          SizedBox(
            height: context.setHeight(AppSize.s32),
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CustomShimmerWidget(
                  width: context.setWidth(AppSize.s75),
                  height: context.setHeight(AppSize.s32),
                  radius: context.setMinSize(AppSize.s36),
                ).marginOnly(end: context.setWidth(AppSize.s8));
              },
            ),
          ),
          verticalSpace(context, AppSize.s20),
          CustomShimmerWidget(
            width: context.setWidth(AppSize.s80),
            height: context.setHeight(AppSize.s20),
          ),
          verticalSpace(context, AppSize.s12),
          SizedBox(
            height: context.setHeight(AppSize.s118),
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: context.setWidth(AppSize.s80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomShimmerWidget(
                        height: context.setHeight(AppSize.s80),
                        width: context.setWidth(AppSize.s80),
                        radius: context.setMinSize(AppSize.s8),
                      ),

                      verticalSpace(context, AppSize.s4),
                      CustomShimmerWidget(
                        width: context.setWidth(AppSize.s50),
                        height: context.setHeight(AppSize.s14),
                      ),
                      verticalSpace(context, AppSize.s4),
                      CustomShimmerWidget(
                        width: context.setWidth(AppSize.s70),
                        height: context.setHeight(AppSize.s14),
                      ),
                    ],
                  ).marginOnly(end: context.setWidth(AppSize.s10)),
                );
              },
            ),
          ),
          verticalSpace(context, AppSize.s20),
          CustomShimmerWidget(
            width: context.setWidth(AppSize.s80),
            height: context.setHeight(AppSize.s20),
          ),
          verticalSpace(context, AppSize.s12),
          CustomShimmerWidget(
            width: double.infinity,
            height: context.setHeight(AppSize.s100),
            radius: context.setMinSize(AppSize.s8),
          ),
        ],
      ),
    );
  }
}
