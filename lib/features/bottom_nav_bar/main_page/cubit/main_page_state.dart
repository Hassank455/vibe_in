import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/slider_model.dart';

class MainPageState {
  final RequestsStatus sliderState;
  final RequestsStatus bestSellerState;
  final RequestsStatus packagesState;
  final List<SliderModel>? sliderModel;
  final List<ProductModel>? bestSellerModel;
  final List<PackageModel>? packagesModel;
  final String? error;
  const MainPageState({
    this.sliderState = RequestsStatus.initial,
    this.bestSellerState = RequestsStatus.initial,
    this.packagesState = RequestsStatus.initial,
    this.sliderModel,
    this.bestSellerModel,
    this.packagesModel,
    this.error,
  });

  MainPageState copyWith({
    RequestsStatus? sliderState,
    RequestsStatus? bestSellerState,
    RequestsStatus? packagesState,
    List<SliderModel>? sliderModel,
    List<ProductModel>? bestSellerModel,
    List<PackageModel>? packagesModel,
    String? error,
  }) {
    return MainPageState(
      sliderState: sliderState ?? this.sliderState,
      bestSellerState: bestSellerState ?? this.bestSellerState,
      packagesState: packagesState ?? this.packagesState,
      sliderModel: sliderModel ?? this.sliderModel,
      bestSellerModel: bestSellerModel ?? this.bestSellerModel,
      packagesModel: packagesModel ?? this.packagesModel,
      error: error ?? this.error,
    );
  }
}
