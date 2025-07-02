import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/models/category_model.dart';

class ItemFilterBottomSheet extends StatelessWidget {
  final CategoryModel categoryModel;
  final List<int> selectedCategory;
  const ItemFilterBottomSheet({
    super.key,
    required this.categoryModel,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final productsCubit = context.read<ProductsCubit>();

    return GestureDetector(
      onTap: () {
        productsCubit.selectCategory(categoryModel.id!);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              selectedCategory.contains(categoryModel.id)
                  ? AppColors.black
                  : AppColors.textFiledBackground,
          borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s6)),
        ),
        child: CustomText(
          text: categoryModel.name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeightHelper.medium,
            color:
                selectedCategory.contains(categoryModel.id)
                    ? AppColors.white
                    : null,
          ),
        ),
      ),
    );
  }
}
