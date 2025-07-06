import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/device_utils.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/models/category_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/widgets/filter_bottom_sheet/item_filter_bottom_sheet.dart';

class FilterProductsBottomSheet extends StatelessWidget {
  const FilterProductsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final productsCubit = context.read<ProductsCubit>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: context.setWidth(AppSize.s16)),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.setMinSize(AppSize.s15)),
          topRight: Radius.circular(context.setMinSize(AppSize.s15)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: context.setHeight(AppSize.s5),
            width: context.setWidth(AppSize.s53),
            margin: EdgeInsets.only(
              top: context.setMinSize(AppSize.s15),
              bottom: context.setMinSize(AppSize.s5),
            ),
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(
                context.setMinSize(AppSize.s2),
              ),
            ),
          ),
          verticalSpace(context, AppSize.s20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.filter.tr(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: context.setSp(AppSize.s20),
                ),
              ),
              GestureDetector(
                onTap: () {
                  productsCubit.resetCategories();
                },
                child: CustomText(
                  text: AppStrings.reset.tr(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: context.setSp(AppSize.s12),
                  ),
                ),
              ),
            ],
          ),

          verticalSpace(context, AppSize.s30),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state.categoryStatus == RequestsStatus.loading) {
                return Container();
              } else if (state.categoryStatus == RequestsStatus.success) {
                final List<CategoryModel>? categories = state.categoryModel;
                final List<int>? selectedCategory = state.selectedCategory;
                return GridView.count(
                  crossAxisCount: DeviceUtils.valueDecider<int>(
                    context,
                    onMobile: 3,
                    others: 4,
                  ),
                  mainAxisSpacing: context.setMinSize(AppSize.s20),
                  crossAxisSpacing: context.setMinSize(AppSize.s7),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.5,
                  children: List.generate(
                    categories!.length,
                    (index) => ItemFilterBottomSheet(
                      categoryModel: categories[index],
                      selectedCategory: selectedCategory!,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          verticalSpace(context, AppSize.s40),
          CustomElevatedButton(
            onTap: () {
              productsCubit.refreshProducts();
              context.pop();
            },
            title: AppStrings.filter.tr(),
          ),
          verticalSpace(context, AppSize.s40),
        ],
      ),
    );
  }
}
