import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_state.dart';
import 'package:vibe_in/features/package_details/ui/widgets/customize_package_bottom_sheet_widgets/alternative_product_for_package_widget.dart';
import 'package:vibe_in/features/package_details/ui/widgets/customize_package_bottom_sheet_widgets/primary_products_for_package_widget.dart';
import 'package:vibe_in/features/package_details/ui/widgets/customize_package_bottom_sheet_widgets/text_and_description_package_details_bottom_sheet.dart';

class CustomizePackageBottomSheetWidget extends StatelessWidget {
  const CustomizePackageBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final packageDetailsCubit = context.read<PackageDetailsCubit>();
    final PackageModel package = packageDetailsCubit.state.packageModelCopy!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.setMinSize(AppSize.s15)),
          topRight: Radius.circular(context.setMinSize(AppSize.s15)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: context.setHeight(AppSize.s5),
              width: context.setWidth(AppSize.s53),
              margin: EdgeInsets.only(
                top: context.setHeight(AppSize.s15),
                bottom: context.setHeight(AppSize.s20),
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(
                  context.setMinSize(AppSize.s2),
                ),
              ),
            ),
          ),
          TextAndDescriptionPackageDetailsBottomSheet(title: package.name!),
          verticalSpace(context, AppSize.s20),
          PrimaryProductsForPackageWidget(),
          verticalSpace(context, AppSize.s25),
          BlocBuilder<PackageDetailsCubit, PackageDetailsState>(
            builder: (context, state) {
              return TextAndDescriptionPackageDetailsBottomSheet(
                title: state.selectedProduct!.name!,
              );
            },
          ),
          verticalSpace(context, AppSize.s20),
          AlternativeProductForPackageWidget(),
          verticalSpace(context, AppSize.s30),
          BlocBuilder<PackageDetailsCubit, PackageDetailsState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: AppStrings.addOn.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextSpan(text: ' '),
                        TextSpan(
                          text: '( ${packageDetailsCubit.addOnLength} )',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    text: '\$${packageDetailsCubit.addOnPrice}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.mainBrown,
                      fontWeight: FontWeightHelper.semiBold,
                    ),
                  ),
                ],
              );
            },
          ).marginSymmetric(horizontal: context.setWidth(AppSize.s16)),
          verticalSpace(context, AppSize.s16),
          CustomElevatedButton(
            onTap: () {
              packageDetailsCubit.saveChangesForCustomization();
              context.pop();
            },
            title: AppStrings.saveChanges.tr(),
          ).marginSymmetric(horizontal: context.setWidth(AppSize.s16)),
          verticalSpace(context, AppSize.s30),
        ],
      ),
    );
  }
}
