import 'dart:developer';

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
import 'package:vibe_in/core/widgets/custom_cached_network_image_removed.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_state.dart';

class AlternativeProductForPackageWidget extends StatelessWidget {
  const AlternativeProductForPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageDetailsCubit, PackageDetailsState>(
      builder: (context, state) {
        final List<Alternatives>? alternative =
            state.selectedProduct!.alternatives;

        return SizedBox(
          height: AppSize.s233.h,
          child: ListView.builder(
            itemCount: alternative!.length,
            padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(
                width: AppSize.s130.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: AppSize.s130.h,
                      width: AppSize.s130.w,
                      padding: EdgeInsets.all(AppSize.s10.w),
                      decoration: BoxDecoration(
                        color: AppColors.lightestGray,
                        borderRadius: BorderRadius.circular(AppSize.s8.r),
                      ),
                      child: CustomCachedNetworkImageRemoved(
                        urlImage: alternative[index].image!,
                        height: AppSize.s130.h,
                        width: AppSize.s130.w,
                        borderNumber: AppSize.s1.r,
                        fit: BoxFit.contain,
                      ),
                    ),
                    verticalSpaceRemoved(AppSize.s4),
                    CustomText(
                      text: alternative[index].name,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeightHelper.semiBold,
                      ),
                    ),
                    verticalSpaceRemoved(AppSize.s7),
                    CustomText(
                      // text: alternative[index].description,
                      text: 'description',
                      maxLines: 1,
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                    ),
                    verticalSpaceRemoved(AppSize.s14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${AppStrings.addOn.tr()}:',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall!.copyWith(
                                  color: AppColors.gray,
                                  fontSize: AppSize.s11.sp,
                                ),
                              ),
                              TextSpan(text: ' '),
                              TextSpan(
                                text: '\$${alternative[index].addOn}',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall!.copyWith(
                                  color: AppColors.mainBrown,
                                  fontSize: AppSize.s11.sp,
                                  fontWeight: FontWeightHelper.semiBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<PackageDetailsCubit>()
                                .toggleAlternativeSelection(
                                  alternative[index].id!,
                                );
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (
                              Widget child,
                              Animation<double> animation,
                            ) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child:
                                alternative[index].isSelected
                                    ? Container(
                                      key: const ValueKey('added'),
                                      height: AppSize.s31.h,
                                      width: AppSize.s31.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: AppColors.white,
                                      ),
                                    )
                                    : Container(
                                      key: const ValueKey('add'),
                                      height: AppSize.s31.h,
                                      width: AppSize.s31.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.mainBrown,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.white,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ).marginOnly(end: AppSize.s10.w),
              );
            },
          ),
        );
      },
    );
  }
}
