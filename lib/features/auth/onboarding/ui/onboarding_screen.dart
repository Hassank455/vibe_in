import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

import 'package:vibe_in/features/auth/onboarding/cubit/onboarding_cubit.dart';
import 'package:vibe_in/features/auth/onboarding/cubit/onboarding_state.dart';
import 'package:vibe_in/features/auth/onboarding/ui/widgets/button_and_indicator_widget.dart';
import 'package:vibe_in/features/auth/onboarding/ui/widgets/onboarding_item.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingCubit = context.read<OnboardingCubit>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          if (state.onboardingState == RequestsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.onboardingState == RequestsStatus.success) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: double.infinity,
                  child: PageView(
                    controller: onBoardingCubit.pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      onBoardingCubit.changePage(index);
                    },
                    children:
                        state.onboardingModel!.data!
                            .map((e) => OnboardingItem(onBoardingData: e))
                            .toList(),
                  ),
                ),
                ButtonAndIndicatorWidget(),
              ],
            );
          } else if (state.onboardingState == RequestsStatus.error) {
            return Center(child: CustomText(text: state.error));
          }
          return Container();
        },
      ),
    );
  }
}
