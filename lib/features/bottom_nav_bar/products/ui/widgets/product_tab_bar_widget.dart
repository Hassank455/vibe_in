import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/di/dependency_injection.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text_form_field.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/widgets/filter_bottom_sheet/filter_products_bottom_sheet.dart';

class ProductTabBarWidget extends StatelessWidget {
  const ProductTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
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
                    constraints: BoxConstraints(minWidth: double.infinity),
                    isScrollControlled: true,
                    builder: (context) {
                      return BlocProvider.value(
                        value: cubit,
                        child: FilterProductsBottomSheet(),
                      );
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
                    color: AppColors.textFiledBackground,
                    borderRadius: BorderRadius.circular(
                      context.setMinSize(AppSize.s8),
                    ),
                  ),
                  child: CustomSvgImage(
                    imageName: AppSvgImage.setting,
                    width: context.setWidth(AppSize.s24),
                    height: context.setHeight(AppSize.s24),
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(context, AppSize.s20),
        // Expanded(
        //   child: GridView.count(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: AppSize.s20.h,
        //     crossAxisSpacing: AppSize.s27.w,
        //     shrinkWrap: true,
        //     childAspectRatio: 0.5,
        //     children: List.generate(
        //       10,
        //       (index) => ProductListItemWidget(productModel: ProductModel()),
        //     ),
        //   ),
        // ),
      ],
    ).marginSymmetric(horizontal: context.setWidth(AppSize.s16));
  }
}
