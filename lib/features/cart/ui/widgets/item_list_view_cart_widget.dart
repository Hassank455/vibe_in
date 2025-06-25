import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/cart/ui/widgets/quantity_increase_dicrease_widget.dart';

class ItemListViewCartWidget extends StatelessWidget {
  const ItemListViewCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: context.setHeight(AppSize.s106),
          width: context.setWidth(AppSize.s100),
          padding: EdgeInsets.symmetric(
            horizontal: context.setWidth(AppSize.s12),
            vertical: context.setHeight(AppSize.s15),
          ),
          decoration: BoxDecoration(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).cardColor
                    : AppColors.textFiledBackground,
            borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
          ),
          child: CustomCachedNetworkImage(
            urlImage:
                'https://chickchack.s3.eu-west-2.amazonaws.com/customer-dashboard/1744786351349Rectangle_39_1_.png',
            height: context.setHeight(AppSize.s75),
            width: context.setWidth(AppSize.s75),
            fit: BoxFit.contain,
          ),
        ),
        horizontalSpace(context, AppSize.s10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              verticalSpace(context, AppSize.s4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomText(
                      text: 'Brilliance Yumberry Red Natural',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  horizontalSpace(context, AppSize.s10),
                  CustomText(
                    text: '20.00\$',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: context.setSp(AppSize.s18),
                      color: AppColors.mainBrown,
                    ),
                  ),
                ],
              ),

              verticalSpace(context, AppSize.s5),
              CustomText(
                text: 'Dolce Gusto',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
              ),
              verticalSpace(context, AppSize.s5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuantityIncreaseDecreaseWidget(
                    onTapDecrease: () {},
                    onTapIncrease: () {},
                    quantity: '1',
                    backgroundColor: AppColors.textFiledBackground,
                  ),
                  Row(
                    children: [
                      CustomSvgImage(
                        imageName: AppSvgImage.trash,
                        width: AppSize.s24,
                        height: AppSize.s24,
                      ),
                      horizontalSpace(context, AppSize.s4),
                      CustomText(
                        text: AppStrings.remove.tr(),
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
