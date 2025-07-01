import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vibe_in/core/di/dependency_injection.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/helpers.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_cubit.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/cubit/profile_cubit.dart';

class ButtonAndResendOtpWidget extends StatelessWidget {
  const ButtonAndResendOtpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final verificationCodeCubit = context.read<VerificationCubit>();

    return BlocConsumer<VerificationCubit, VerificationState>(
      listener: (_, state) async {
        if (state.verificationStatus == RequestsStatus.success) {
          await verificationCodeCubit.saveUserToken(
            state.verificationResponse!.data!.token!,
          );
          // ✅ Close and reset cubits manually
          if (getIt.isRegistered<ProfileCubit>()) {
            await getIt<ProfileCubit>().close();
            await getIt.unregister<ProfileCubit>();
            getIt.registerLazySingleton<ProfileCubit>(
              () => ProfileCubit(getIt()),
            );
          } else {
            getIt.registerLazySingleton<ProfileCubit>(
              () => ProfileCubit(getIt()),
            );
          }

          if (getIt.isRegistered<MainPageCubit>()) {
            await getIt<MainPageCubit>().close();
            await getIt.unregister<MainPageCubit>();
            getIt.registerLazySingleton<MainPageCubit>(
              () => MainPageCubit(getIt()),
            );
          } else {
            getIt.registerLazySingleton<MainPageCubit>(
              () => MainPageCubit(getIt()),
            );
          }

          context.pushNamedAndRemoveUntil(
            Routes.homeScreen,
            predicate: (route) => false,
          );
        } else if (state.verificationStatus == RequestsStatus.error ||
            state.resendCodeStatus == RequestsStatus.error) {
          Helper().showSnackBar(context: context, text: state.error);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomElevatedButton(
              key: Key('verify_button'),
              onTap: () {
                if (state.start == 0) {
                  Helper().showSnackBar(
                    context: context,
                    text: AppStrings.timeOut.tr(),
                  );
                } else {
                  verificationCodeCubit.otpVerification();
                }
              },
              isLoading: state.verificationStatus == RequestsStatus.loading,
              title: AppStrings.verify.tr(),
            ),
            verticalSpace(context,AppSize.s40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: AppStrings.didNotReceiveCode.tr(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.gray,
                    fontWeight: FontWeightHelper.regular,
                  ),
                ),
                verticalSpace(context,AppSize.s8),
                CustomText(
                  text: verificationCodeCubit.formatTime(),
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: AppColors.mainBrown),
                ),
                verticalSpace(context,AppSize.s8),
                state.resendCodeStatus == RequestsStatus.loading
                    ? LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.mainBrown,
                      size: context.setMinSize(AppSize.s40),
                    )
                    : GestureDetector(
                      onTap: () {
                        verificationCodeCubit.resendCode();
                      },

                      child: CustomText(
                        text: AppStrings.resendCode.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
              ],
            ),
          ],
        );
      },
    );
  }
}
