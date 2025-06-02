import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';

class PackageDetailsState {
  final RequestsStatus packageState;
  final PackageModel? packageModel;
  final PackageModel? packageModelCopy;
  final Map<int, Alternatives>? selectedAlternatives;
  final Products? selectedProduct;
  final Cycles? selectedCycle;
  final double totalPrice;
  final double addOnPrice;
  final int addOnLength;
  final bool isSavedChanged;
  final String? error;
  const PackageDetailsState({
    this.packageState = RequestsStatus.initial,
    this.packageModel,
    this.packageModelCopy,
    this.selectedAlternatives = const {},
    this.selectedProduct,
    this.selectedCycle,
    this.totalPrice = 0.0,
    this.addOnPrice = 0.0,
    this.addOnLength = 0,
    this.isSavedChanged = false,
    this.error,
  });

  PackageDetailsState copyWith({
    RequestsStatus? packageState,
    PackageModel? packageModel,
    PackageModel? packageModelCopy,
    Map<int, Alternatives>? selectedAlternatives,
    Products? selectedProduct,
    Cycles? selectedCycle,
    double? totalPrice,
    double? addOnPrice,
    int? addOnLength,
    bool? isSavedChanged,
    String? error,
  }) {
    return PackageDetailsState(
      packageState: packageState ?? this.packageState,
      packageModel: packageModel ?? this.packageModel,
      packageModelCopy: packageModelCopy ?? this.packageModelCopy,
      selectedAlternatives: selectedAlternatives ?? this.selectedAlternatives,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      selectedCycle: selectedCycle ?? this.selectedCycle,
      totalPrice: totalPrice ?? this.totalPrice,
      addOnPrice: addOnPrice ?? this.addOnPrice,
      addOnLength: addOnLength ?? this.addOnLength,
      isSavedChanged: isSavedChanged ?? this.isSavedChanged,
      error: error ?? this.error,
    );
  }
}
