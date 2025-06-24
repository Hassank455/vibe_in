import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class OrderListViewItemWidget extends StatelessWidget {
  const OrderListViewItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: Size(context.screenWidth, AppSize.s177),
      width: context.screenWidth,
      height: context.setMinSize(AppSize.s177),
      child: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Wed 12 Mar 2025 - 11:49 AM',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeightHelper.semiBold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.setWidth(AppSize.s25),
                      vertical: context.setHeight(AppSize.s6),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightYellow,
                      borderRadius: BorderRadius.circular(
                        context.setMinSize(AppSize.s6),
                      ),
                    ),
                    child: CustomText(
                      text: 'Pending',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: AppColors.yellow),
                    ),
                  ),
                ],
              ),
              verticalSpace(context, AppSize.s16),
              GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.orderDetailsScreen);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: context.setWidth(AppSize.s100),
                      height: context.setHeight(AppSize.s106),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.setWidth(AppSize.s12),
                        vertical: context.setHeight(AppSize.s16),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          context.setMinSize(AppSize.s6),
                        ),
                        color: AppColors.textFiledBackground,
                      ),
                      child: CustomCachedNetworkImage(
                        urlImage:
                            'https://chickchack.s3.eu-west-2.amazonaws.com/customer-dashboard/1744786351349Rectangle_39_1_.png',
                        height: AppSize.s146,
                        width: AppSize.s146,
                        fit: BoxFit.contain,
                      ),
                    ),
                    horizontalSpace(context, AppSize.s10),
                    SizedBox(
                      // width: context.setWidth(AppSize.s150),
                      width: context.sizeProvider.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Brilliance Yumberry Red Natural',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          verticalSpace(context, AppSize.s4),
                          CustomText(
                            text: 'Dolce Gusto',
                            maxLines: 1,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                          ),
                          verticalSpace(context, AppSize.s4),
                          CustomText(
                            text: '30.0\$',
                            maxLines: 1,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(
                              color: AppColors.mainBrown,
                              fontSize: context.setSp(AppSize.s16),
                            ),
                          ),
                          verticalSpace(context, AppSize.s4),
                          CustomText(
                            text: '${AppStrings.products.tr()}: X2',
                            maxLines: 1,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).marginOnly(bottom: context.setHeight(AppSize.s24));
        }
      ),
    );
  }
}
