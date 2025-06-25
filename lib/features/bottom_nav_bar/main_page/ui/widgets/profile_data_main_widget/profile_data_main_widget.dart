import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
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
    return SizeProvider(
      baseSize: Size(context.scaleWidget, AppSize.s60),
      width: context.scaleWidget,
      height: context.setHeight(AppSize.s60),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.profileStatus == RequestsStatus.loading) {
            return LoadingProfileDataMainWidget();
          } else if (state.profileStatus == RequestsStatus.success) {
            final profileModel = state.profileModel!;
            return Row(
              children: [
                CustomCachedNetworkImage(
                  urlImage: profileModel.profileData!.avatar!,
                  height: context.sizeProvider.height,
                  width: context.setWidth(AppSize.s60),
                  isCircle: true,
                  fit: BoxFit.contain,
                ),
                horizontalSpace(context, AppSize.s10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: profileModel.profileData!.name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeightHelper.bold,
                      ),
                    ),
                    verticalSpace(context, AppSize.s7),
                    CustomText(
                      text: AppStrings.goodMorning.tr(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeightHelper.regular,
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => context.pushNamed(Routes.cartScreen),
                  child: Container(
                    height: context.setHeight(AppSize.s48),
                    width: context.setWidth(AppSize.s48),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: context.setHeight(AppSize.s7),
                      horizontal: context.setWidth(AppSize.s12),
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
                        height: context.setHeight(AppSize.s24),
                        width: context.setWidth(AppSize.s24),
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.white
                                : AppColors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ).marginSymmetric(horizontal: context.setWidth(AppSize.s16)),
    );
  }
}
