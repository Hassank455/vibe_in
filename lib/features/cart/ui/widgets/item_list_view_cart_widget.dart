import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          height: AppSize.s106.h,
          width: AppSize.s100.w,
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.s12.w,
            vertical: AppSize.s15.h,
          ),
          decoration: BoxDecoration(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).cardColor
                    : AppColors.textFiledBackground,
            borderRadius: BorderRadius.circular(AppSize.s8.r),
          ),
          child: CustomCachedNetworkImage(
            urlImage:
                'https://chickchack.s3.eu-west-2.amazonaws.com/customer-dashboard/1744786351349Rectangle_39_1_.png',
            height: AppSize.s75.h,
            width: AppSize.s75.w,
            fit: BoxFit.contain,
            borderNumber: AppSize.s1.r,
          ),
        ),
        horizontalSpace(AppSize.s10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              verticalSpace(AppSize.s4),
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
                  horizontalSpace(AppSize.s10),
                  CustomText(
                    text: '20.00\$',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s18.sp,
                      color: AppColors.mainBrown,
                    ),
                  ),
                ],
              ),

              verticalSpace(AppSize.s5),
              CustomText(
                text: 'Dolce Gusto',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
              ),
              verticalSpace(AppSize.s5),
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
                      horizontalSpace(AppSize.s4),
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
