import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';

class PackageDetailsState {
  final RequestsStatus packageState;
  final PackageModel? packageModel;
  final Products? selectedProduct;

  final String? error;
  const PackageDetailsState({
    this.packageState = RequestsStatus.initial,
    this.packageModel,
    this.selectedProduct,
    this.error,
  });

  PackageDetailsState copyWith({
    RequestsStatus? packageState,
    PackageModel? packageModel,
    Products? selectedProduct,
    String? error,
  }) {
    return PackageDetailsState(
      packageState: packageState ?? this.packageState,
      packageModel: packageModel ?? this.packageModel,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      error: error ?? this.error,
    );
  }
}
