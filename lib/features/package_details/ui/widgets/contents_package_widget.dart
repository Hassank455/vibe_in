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
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';

class ContentsPackageWidget extends StatelessWidget {
  const ContentsPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final updatedProducts =
        context.read<PackageDetailsCubit>().state.packageModelCopy?.products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppStrings.contents.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeightHelper.medium),
        ),
        verticalSpace(AppSize.s12),
        SizedBox(
          height: AppSize.s120.h,
          child: ListView.builder(
            itemCount: updatedProducts?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final product = updatedProducts![index];

              Alternatives? selectedAlternative;
              try {
                selectedAlternative = product.alternatives?.firstWhere(
                  (alt) => alt.isSelected,
                );
              } catch (e) {
                selectedAlternative = null;
              }

              final displayName = selectedAlternative?.name ?? product.name;
              final displayImage = selectedAlternative?.image ?? product.image;
              return SizedBox(
                width: AppSize.s80.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: AppSize.s80.h,
                      width: AppSize.s80.w,
                      padding: EdgeInsets.all(AppSize.s5.w),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Theme.of(context).cardColor
                                : AppColors.lightestGray,
                        borderRadius: BorderRadius.circular(AppSize.s8.r),
                      ),
                      child: CustomCachedNetworkImage(
                        urlImage: displayImage!,
                        height: AppSize.s70.h,
                        width: AppSize.s70.w,
                        borderNumber: AppSize.s1.r,
                        fit: BoxFit.contain,
                      ),
                    ),
                    verticalSpace(AppSize.s4),
                    CustomText(
                      text: displayName,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeightHelper.medium,
                      ),
                    ),
                  ],
                ).marginOnly(end: AppSize.s10.w),
              );
            },
          ),
        ),
      ],
    );
  }
}
