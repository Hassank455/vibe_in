import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/auth/onboarding/cubit/onboarding_state.dart';
import 'package:vibe_in/features/auth/onboarding/data/models/onboarding_model.dart';
import 'package:vibe_in/features/auth/onboarding/data/repo/onboarding_repo.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepo _onboardingRepo;
  OnboardingCubit(this._onboardingRepo) : super(const OnboardingState());

  final PageController pageController = PageController();

  Future<void> getOnboardingData() async {
    emit(state.copyWith(onboardingState: RequestsStatus.loading));
    final response = await _onboardingRepo.getOnboarding();
    if (response.isSuccess) {
      emit(
        state.copyWith(
          onboardingState: RequestsStatus.success,
          onboardingModel: response.data,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          error: errorMessage,
          onboardingState: RequestsStatus.error,
        ),
      );
    }
  }

  void changePage(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
