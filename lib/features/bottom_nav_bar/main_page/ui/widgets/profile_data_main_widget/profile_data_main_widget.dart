import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/profile_data_main_widget/loading_profile_data_main_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/cubit/profile_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/cubit/profile_state.dart';

class ProfileDataMainWidget extends StatelessWidget {
  const ProfileDataMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.profileStatus == RequestsStatus.loading) {
          return LoadingProfileDataMainWidget();
        } else if (state.profileStatus == RequestsStatus.success) {
          final profileModel = state.profileModel!;
          return ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity(
              horizontal: VisualDensity.minimumDensity,
            ),
            leading: CustomCachedNetworkImage(
              urlImage: profileModel.profileData!.avatar!,
              height: AppSize.s60.h,
              width: AppSize.s60.w,
              borderNumber: AppSize.s0.r,
              fit: BoxFit.contain,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: AppSize.s7.h),
              child: CustomText(
                text: profileModel.profileData!.name,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.copyWith(fontSize: AppSize.s14.sp),
              ),
            ),
            subtitle: CustomText(
              text: AppStrings.goodMorning.tr(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeightHelper.regular,
                color: AppColors.gray,
              ),
            ),
            trailing: GestureDetector(
              onTap: () => context.pushNamed(Routes.cartScreen),
              child: Container(
                height: AppSize.s48.h,
                width: AppSize.s48.w,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.s7.h,
                  horizontal: AppSize.s12.w,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                  boxShadow: [AppColors.cartShadowsColors],
                ),
                child: Badge(
                  backgroundColor: AppColors.failure,
                  label: CustomText(
                    text: '2',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeightHelper.bold,
                    ),
                  ),
                  child: CustomSvgImage(
                    imageName: AppSvgImage.shoppingCart,
                    height: AppSize.s24.h,
                    width: AppSize.s24.w,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.white
                            : AppColors.black,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    ).marginSymmetric(horizontal: AppSize.s16.w);
  }
}
