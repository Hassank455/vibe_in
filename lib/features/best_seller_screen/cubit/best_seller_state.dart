import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';

class BestSellerState {
  final RequestsStatus bestSellerState;
  final List<ProductModel>? bestSellerModel;
  final bool isLoadingMore;

  final String? error;
  const BestSellerState({
    this.bestSellerState = RequestsStatus.initial,
    this.bestSellerModel,
    this.isLoadingMore = false,
    this.error,
  });

  BestSellerState copyWith({
    RequestsStatus? bestSellerState,
    List<ProductModel>? bestSellerModel,
    bool? isLoadingMore,
    String? error,
  }) {
    return BestSellerState(
      bestSellerState: bestSellerState ?? this.bestSellerState,
      bestSellerModel: bestSellerModel ?? this.bestSellerModel,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}
