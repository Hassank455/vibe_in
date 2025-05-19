import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/di/dependency_injection.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
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
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return BlocProvider.value(
                    value: packageDetailsCubit,
                    child: const CustomizePackageBottomSheetWidget(),
                  );
                },
              );
            },
            child: Container(
              height: AppSize.s56,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(AppSize.s8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgImage(
                    imageName: AppSvgImage.edit,
                    height: AppSize.s18.h,
                    width: AppSize.s18.w,
                  ),
                  horizontalSpace(AppSize.s10),
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
        horizontalSpace(AppSize.s15),
        Expanded(
          flex: 4,
          child: CustomElevatedButton(
            onTap: () {},
            title: AppStrings.addToCart.tr(),
          ),
        ),
      ],
    ).marginOnly(
      start: AppSize.s16.w,
      end: AppSize.s16.w,
      top: AppSize.s16.h,
      bottom: AppSize.s30.h,
    );
  }
}
