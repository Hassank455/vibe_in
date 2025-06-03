import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_state.dart';

class CustomNavBottom extends StatelessWidget {
  const CustomNavBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder:
          (context, state) => Container(
            height: AppSize.s60.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: AppSize.s34.w),
            decoration: BoxDecoration(
              boxShadow: [AppColors.boxShadowColors],
              // color: Theme.of(context).scaffoldBackgroundColor,
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).cardColor
                      : Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomSvgImage(
                  imageName:
                      homeCubit.indexScreen == 0
                          ? AppSvgImage.homeActive
                          : AppSvgImage.home,
                  width: AppSize.s24,
                  height: AppSize.s24,
                  fit: BoxFit.cover,
                  onTap: () {
                    homeCubit.setIndexScreen(0);
                  },
                ),
                CustomSvgImage(
                  imageName:
                      homeCubit.indexScreen == 1
                          ? AppSvgImage.productsActive
                          : AppSvgImage.products,
                  width: AppSize.s24,
                  height: AppSize.s24,
                  fit: BoxFit.cover,
                  onTap: () {
                    homeCubit.setIndexScreen(1);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    homeCubit.setIndexScreen(2);
                  },
                  child: Container(
                    height: AppSize.s46.h,
                    width: AppSize.s46.w,
                    padding: EdgeInsets.all(AppSize.s11.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: AppColors.black,
                      color:
                          homeCubit.indexScreen == 2
                              ? AppColors.mainBrown
                              : Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white
                              : AppColors.black,
                    ),
                    child: Center(
                      child: CustomSvgImage(
                        imageName: AppSvgImage.scan,
                        width: AppSize.s24,
                        height: AppSize.s24,
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.black
                                : AppColors.white,
                      ),
                    ),
                  ),
                ),
                CustomSvgImage(
                  imageName:
                      homeCubit.indexScreen == 3
                          ? AppSvgImage.ordersActive
                          : AppSvgImage.orders,
                  width: AppSize.s24,
                  height: AppSize.s24,
                  fit: BoxFit.cover,
                  onTap: () {
                    homeCubit.setIndexScreen(3);
                  },
                ),

                CustomSvgImage(
                  imageName:
                      homeCubit.indexScreen == 4
                          ? AppSvgImage.profileActive
                          : AppSvgImage.profile,
                  width: AppSize.s24,
                  height: AppSize.s24,
                  fit: BoxFit.cover,
                  onTap: () {
                    homeCubit.setIndexScreen(4);
                  },
                ),
              ],
            ),
          ),
    );
  }
}
