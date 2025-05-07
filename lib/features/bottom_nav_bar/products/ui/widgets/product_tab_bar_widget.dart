import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text_form_field.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_list_item_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/widgets/filter_bottom_sheet/filter_products_bottom_sheet.dart';

class ProductTabBarWidget extends StatelessWidget {
  const ProductTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(AppSize.s30),
        SizedBox(
          height: AppSize.s48.h,
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
                      width: AppSize.s26.w,
                      height: AppSize.s26.h,
                    ),
                  ),
                ),
              ),
              horizontalSpace(AppSize.s5),
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
                  width: AppSize.s48.w,
                  height: AppSize.s48.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s13.w,
                    vertical: AppSize.s12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textFiledBackground,
                    borderRadius: BorderRadius.circular(AppSize.s8.r),
                  ),
                  child: CustomSvgImage(
                    imageName: AppSvgImage.setting,
                    width: AppSize.s24.w,
                    height: AppSize.s24.h,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(AppSize.s20),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: AppSize.s20.h,
            crossAxisSpacing: AppSize.s27.w,
            shrinkWrap: true,
            childAspectRatio: 0.5,
            children: List.generate(
              10,
              (index) => const ProductListItemWidget(),
            ),
          ),
        ),
      ],
    ).marginSymmetric(horizontal: AppSize.s16.w);
  }
}
