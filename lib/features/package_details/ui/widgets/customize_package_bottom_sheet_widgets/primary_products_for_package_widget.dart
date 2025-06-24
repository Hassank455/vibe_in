import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image_removed.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_state.dart';

class PrimaryProductsForPackageWidget extends StatelessWidget {
  const PrimaryProductsForPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final packageDetailsCubit = context.read<PackageDetailsCubit>();
    return BlocBuilder<PackageDetailsCubit, PackageDetailsState>(
      builder: (context, state) {
        return SizedBox(
          height: AppSize.s137.h,
          child: ListView.builder(
            itemCount: state.packageModelCopy!.products!.length,
            padding: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  packageDetailsCubit.changeSelectedProduct(
                    state.packageModelCopy!.products![index],
                  );
                },
                child: SizedBox(
                  width: AppSize.s110.w,
                  height: AppSize.s137.h,
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSize.s110.h,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomCachedNetworkImageRemoved(
                              urlImage:
                                  state
                                      .packageModelCopy!
                                      .products![index]
                                      .image!,
                              height: AppSize.s110.h,
                              width: double.infinity,
                              borderNumber: AppSize.s4.r,
                              fit: BoxFit.contain,
                            ),
                            if (state.selectedProduct!.id ==
                                state.packageModelCopy!.products![index].id)
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(AppSize.s4.r),
                                  ),
                                ),
                              ),
                            Container(
                              alignment: Alignment.center,
                              width: AppSize.s42.w,
                              height: AppSize.s42.h,
                              decoration: BoxDecoration(
                                color:
                                    state.selectedProduct!.id ==
                                            state
                                                .packageModelCopy!
                                                .products![index]
                                                .id
                                        ? AppColors.mainBrown
                                        : AppColors.black,
                                shape: BoxShape.circle,
                              ),
                              child: CustomSvgImage(
                                imageName: AppSvgImage.edit,
                                color: AppColors.white,
                                height: AppSize.s18.h,
                                width: AppSize.s18.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceRemoved(AppSize.s10),
                      CustomText(
                        text: state.packageModelCopy!.products![index].name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: AppSize.s12.sp,
                        ),
                      ),
                    ],
                  ),
                ).marginOnly(end: AppSize.s10.w),
              );
            },
          ),
        );
      },
    );
  }
}
