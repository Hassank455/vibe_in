import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/constants.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/shared_pref_helper.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/features/auth/onboarding/cubit/onboarding_cubit.dart';
import 'package:vibe_in/features/auth/onboarding/cubit/onboarding_state.dart';

class ButtonAndIndicatorWidget extends StatelessWidget {
  const ButtonAndIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingCubit = context.read<OnboardingCubit>();

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return SizedBox(
          height: context.screenHeight * 0.2,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  state.onboardingModel!.data!.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(
                      horizontal: context.setWidth(AppSize.s5),
                    ),
                    width: context.setWidth(AppSize.s20),
                    height: context.setHeight(AppSize.s3),
                    decoration: BoxDecoration(
                      color:
                          state.currentIndex == index
                              ? AppColors.white
                              : AppColors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(
                        context.setMinSize(AppSize.s2),
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpace(context, AppSize.s34),
              Hero(
                tag: 'login_button',
                flightShuttleBuilder: (
                  flightContext,
                  animation,
                  flightDirection,
                  fromHeroContext,
                  toHeroContext,
                ) {
                  final delayedAnimation = CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0, 1.0, curve: Curves.easeOut),
                  );
                  return ScaleTransition(
                    scale: delayedAnimation,
                    child: toHeroContext.widget,
                  );
                },
                child: CustomElevatedButton(
                  onTap: () async {
                    if (state.currentIndex <
                        state.onboardingModel!.data!.length - 1) {
                      onBoardingCubit.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      await SharedPrefHelper().setData(
                        SharedPrefKeys.onBoardingSeen,
                        true,
                      );
                      context.pushReplacementNamed(Routes.loginScreen);
                    }
                  },
                  title:
                      state.currentIndex == 0
                          ? AppStrings.getStarted.tr()
                          : state.currentIndex <
                              state.onboardingModel!.data!.length - 1
                          ? AppStrings.next.tr()
                          : AppStrings.startNow.tr(),
                ),
              ),
            ],
          ).marginOnly(
            bottom: context.setHeight(AppSize.s40),
            start: context.setWidth(AppSize.s16),
            end: context.setWidth(AppSize.s16),
          ),
        );
      },
    );
  }
}
