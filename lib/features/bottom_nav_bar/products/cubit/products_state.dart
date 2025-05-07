import 'package:vibe_in/core/helpers/enum.dart';

class ProductsState {
  final RequestsStatus productsStatus;
  final int currentIndex;
  final String? error;

  const ProductsState({
    this.productsStatus = RequestsStatus.initial,
    this.currentIndex = 0,
    this.error,
  });

  ProductsState copyWith({
    RequestsStatus? productsStatus,
    String? error,
    int? currentIndex,
  }) {
    return ProductsState(
      productsStatus: productsStatus ?? this.productsStatus,
      error: error ?? this.error,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
