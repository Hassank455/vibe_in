import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_state.dart';

class CustomNavBottom extends StatelessWidget {
  const CustomNavBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    final items = [
      (AppSvgImage.home, AppSvgImage.homeActive),
      (AppSvgImage.products, AppSvgImage.productsActive),
      (AppSvgImage.scan, null),
      (AppSvgImage.orders, AppSvgImage.ordersActive),
      (AppSvgImage.profile, AppSvgImage.profileActive),
    ];

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          height: context.setHeight(AppSize.s60),
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: context.setWidth(AppSize.s34),
          ),
          decoration: BoxDecoration(
            boxShadow: [AppColors.boxShadowColors],
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).cardColor
                    : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              final isSelected = homeCubit.indexScreen == index;

              if (index == 2) {
                return GestureDetector(
                  onTap: () => homeCubit.setIndexScreen(index),
                  child: Container(
                    height: context.setHeight(AppSize.s46),
                    width: context.setWidth(AppSize.s46),
                    padding: EdgeInsets.all(context.setMinSize(AppSize.s11)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          isSelected
                              ? AppColors.mainBrown
                              : Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white
                              : AppColors.black,
                    ),
                    child: Center(
                      child: CustomSvgImage(
                        imageName: AppSvgImage.scan,
                        width: context.setWidth(AppSize.s24),
                        height: context.setHeight(AppSize.s24),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.black
                                : AppColors.white,
                      ),
                    ),
                  ),
                );
              }

              final (defaultIcon, activeIcon) = items[index];
              final iconToShow =
                  isSelected && activeIcon != null ? activeIcon : defaultIcon;

              return CustomSvgImage(
                imageName: iconToShow,
                width: context.setWidth(AppSize.s24),
                height: context.setHeight(AppSize.s24),
                fit: BoxFit.cover,
                onTap: () => homeCubit.setIndexScreen(index),
              );
            }),
          ),
        );
      },
    );
  }
}
