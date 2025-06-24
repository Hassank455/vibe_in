import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
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
          topLeft: Radius.circular(AppSize.s15.r),
          topRight: Radius.circular(AppSize.s15.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: AppSize.s5.h,
              width: AppSize.s53.w,
              margin: EdgeInsets.only(
                top: AppSize.s15.h,
                bottom: AppSize.s20.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(AppSize.s2.r),
              ),
            ),
          ),
          TextAndDescriptionPackageDetailsBottomSheet(title: package.name!),
          verticalSpaceRemoved(AppSize.s20),
          PrimaryProductsForPackageWidget(),
          verticalSpaceRemoved(AppSize.s25),
          BlocBuilder<PackageDetailsCubit, PackageDetailsState>(
            builder: (context, state) {
              return TextAndDescriptionPackageDetailsBottomSheet(
                title: state.selectedProduct!.name!,
              );
            },
          ),
          verticalSpaceRemoved(AppSize.s20),
          AlternativeProductForPackageWidget(),
          verticalSpaceRemoved(AppSize.s30),
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
                          // text: '( ${state.addOnLength} )',
                          text: '( ${packageDetailsCubit.addOnLength} )',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    // text: '\$${state.addOnPrice}',
                    text: '\$${packageDetailsCubit.addOnPrice}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.mainBrown,
                      fontWeight: FontWeightHelper.semiBold,
                    ),
                  ),
                ],
              );
            },
          ).marginSymmetric(horizontal: AppSize.s16.w),
          verticalSpaceRemoved(AppSize.s16),
          CustomElevatedButton(
            onTap: () {
              packageDetailsCubit.saveChangesForCustomization();
              context.pop();
            },
            title: AppStrings.saveChanges.tr(),
          ).marginSymmetric(horizontal: AppSize.s16.w),
          verticalSpaceRemoved(AppSize.s30),
        ],
      ),
    );
  }
}
