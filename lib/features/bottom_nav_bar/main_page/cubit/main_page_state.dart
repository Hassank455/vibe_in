import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/slider_model.dart';

class MainPageState {
  final RequestsStatus sliderState;
  final SliderModel? sliderModel;
  final String? error;
  const MainPageState({
    this.sliderState = RequestsStatus.initial,
    this.sliderModel,
    this.error,
  });

  MainPageState copyWith({
    RequestsStatus? sliderState,
    SliderModel? sliderModel,
    String? error,
  }) {
    return MainPageState(
      sliderState: sliderState ?? this.sliderState,
      sliderModel: sliderModel ?? this.sliderModel,
      error: error ?? this.error,
    );
  }
}
