import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text_form_field.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/widgets/filter_bottom_sheet/filter_products_bottom_sheet.dart';

class PackagesTabBarWidget extends StatelessWidget {
  const PackagesTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(context, AppSize.s30),
        SizedBox(
          height: context.setHeight(AppSize.s48),
          child: Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: TextEditingController(),
                  validator: (val) {},
                  hintText: AppStrings.search.tr(),
                  prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: AppSize.s16,
                      end: AppSize.s12,
                    ),
                    child: CustomSvgImage(
                      imageName: AppSvgImage.search,
                      width: context.setWidth(AppSize.s26),
                      height: context.setHeight(AppSize.s26),
                    ),
                  ),
                ),
              ),
              horizontalSpace(context, AppSize.s5),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,

                    isScrollControlled: true,
                    builder: (context) {
                      return FilterProductsBottomSheet();
                    },
                  );
                },
                child: Container(
                  width: context.setWidth(AppSize.s48),
                  height: context.setHeight(AppSize.s48),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setWidth(AppSize.s13),
                    vertical: context.setHeight(AppSize.s12),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightBrownBackground,
                    borderRadius: BorderRadius.circular(
                      context.setMinSize(AppSize.s8),
                    ),
                  ),
                  child: CustomSvgImage(
                    imageName: AppSvgImage.setting,
                    width: context.setWidth(AppSize.s24),
                    height: context.setHeight(AppSize.s24),
                    color: AppColors.mainBrown,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(context, AppSize.s20),
        // Expanded(
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: 5,
        //     itemBuilder:
        //         (context, index) => PackagesListItemWidget(
        //           packageModel: PackageModel(),
        //           height: AppSize.s305,
        //           heightImage: AppSize.s194,
        //         ).marginOnly(bottom: AppSize.s20.h),
        //   ),
        // ),
      ],
    ).marginSymmetric(horizontal: context.setWidth(AppSize.s16));
  }
}
