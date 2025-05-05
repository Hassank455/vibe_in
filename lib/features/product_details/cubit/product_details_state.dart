import 'package:vibe_in/core/helpers/enum.dart';

class ProductDetailsState {
  final RequestsStatus sliderState;
  final String? imageSelected;
  final int currentIndex;
  final int selectedPriceIndex;
  final int selectedQuantity;
  final String? error;

  const ProductDetailsState({
    this.sliderState = RequestsStatus.initial,
    this.imageSelected,
    this.currentIndex = 0,
    this.selectedPriceIndex = 0,
    this.selectedQuantity = 1,
    this.error,
  });

  ProductDetailsState copyWith({
    RequestsStatus? sliderState,
    String? imageSelected,
    int? currentIndex,
    int? selectedPriceIndex,
    int? selectedQuantity,
    String? error,
  }) {
    return ProductDetailsState(
      sliderState: sliderState ?? this.sliderState,
      imageSelected: imageSelected ?? this.imageSelected,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedPriceIndex: selectedPriceIndex ?? this.selectedPriceIndex,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
      error: error ?? this.error,
    );
  }
}
