import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/auth/onboarding/data/models/onboarding_model.dart';

class OnboardingState {
  final int currentIndex;
  final RequestsStatus onboardingState;
  final OnboardingModel? onboardingModel;
  final String? error;
  const OnboardingState({
    this.currentIndex = 0,
    this.onboardingState = RequestsStatus.initial,
    this.onboardingModel,
    this.error,
  });

  OnboardingState copyWith({
    int? currentIndex,
    RequestsStatus? onboardingState,
    OnboardingModel? onboardingModel,
    String? error,
  }) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      onboardingState: onboardingState ?? this.onboardingState,
      onboardingModel: onboardingModel ?? this.onboardingModel,
      error: error ?? this.error,
    );
  }
}
