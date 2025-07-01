import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';
import 'package:vibe_in/features/package_details/ui/widgets/customize_package_bottom_sheet_widgets/customize_package_bottom_sheet_widget.dart';

class CustomizeAndAddToCartWidget extends StatelessWidget {
  final PackageDetailsCubit packageDetailsCubit;
  const CustomizeAndAddToCartWidget({
    super.key,
    required this.packageDetailsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: () {
              packageDetailsCubit.addValueForAddOn();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                constraints: BoxConstraints(minWidth: double.infinity),

                builder: (context) {
                  return BlocProvider.value(
                    value: packageDetailsCubit,
                    child: const CustomizePackageBottomSheetWidget(),
                  );
                },
              ).whenComplete(() {
                context
                    .read<PackageDetailsCubit>()
                    .resetSelectedAlternativeAndAddOnPriceWhenCloseBottomSheetWithoutSave();
              });
            },
            child: Container(
              height: context.setHeight(AppSize.s56),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(
                  context.setMinSize(AppSize.s8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgImage(
                    imageName: AppSvgImage.edit,
                    height: context.setHeight(AppSize.s18),
                    width: context.setWidth(AppSize.s18),
                  ),
                  horizontalSpace(context, AppSize.s10),
                  CustomText(
                    text: AppStrings.customize.tr(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        horizontalSpace(context, AppSize.s15),
        Expanded(
          flex: 4,
          child: CustomElevatedButton(
            onTap: () {},
            title: AppStrings.addToCart.tr(),
          ),
        ),
      ],
    ).marginOnly(
      start: context.setWidth(AppSize.s16),
      end: context.setWidth(AppSize.s16),
      top: context.setHeight(AppSize.s16),
      bottom: context.setHeight(AppSize.s30),
    );
  }
}
