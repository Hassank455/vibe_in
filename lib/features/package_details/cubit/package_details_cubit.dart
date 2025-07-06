import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_state.dart';
import 'package:vibe_in/features/package_details/data/repo/package_details_repo.dart';

class PackageDetailsCubit extends Cubit<PackageDetailsState> {
  final PackageDetailsRepo _packageDetailsRepo;
  PackageDetailsCubit(this._packageDetailsRepo)
    : super(const PackageDetailsState());

  void getPackages(int id) async {
    emit(state.copyWith(packageState: RequestsStatus.loading));
    final response = await _packageDetailsRepo.getSinglePackage(id: id);
    if (response.isSuccess) {
      emit(
        state.copyWith(
          packageModel: response.data!.data,
          packageModelCopy: response.data!.data,
          selectedProduct: response.data!.data.products?.first,
          packageState: RequestsStatus.success,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(error: errorMessage, packageState: RequestsStatus.error),
      );
    }
  }

  void changeSelectedProduct(Products product) {
    emit(state.copyWith(selectedProduct: product));
  }

  void changeSelectedCycle(Cycles cycle) {
    emit(
      state.copyWith(
        selectedCycle: cycle,
        totalPrice: double.parse(cycle.price!) + state.addOnPrice,
      ),
    );
  }

  late double addOnPrice;
  late int addOnLength;
  void addValueForAddOn() {
    addOnPrice = state.addOnPrice;
    addOnLength = state.addOnLength;
  }

  void toggleAlternativeSelection(int alternativeId) {
    final selectedProduct = state.selectedProduct;
    if (selectedProduct == null) return;

    Alternatives? currentSelectedAlt;
    try {
      currentSelectedAlt = selectedProduct.alternatives?.firstWhere(
        (alt) => alt.isSelected,
      );
    } catch (_) {
      currentSelectedAlt = null;
    }

    final updatedAlternatives =
        selectedProduct.alternatives?.map((alt) {
          // If this is the alternative we pressed for
          if (alt.id == alternativeId) {
            final isNowSelected = !alt.isSelected;

            // Remove previous price if there is a previous alternative specified
            if (currentSelectedAlt != null) {
              addOnPrice -= double.parse(currentSelectedAlt.addOn ?? '0.0');
              addOnLength -= 1;
            }

            // If we define this alternative now, we add its price.
            if (isNowSelected) {
              addOnPrice += double.parse(alt.addOn ?? '0.0');
              addOnLength += 1;
            }

            return alt.copyWith(isSelected: isNowSelected);
          } else {
            // All other alternatives must be unspecified.
            return alt.copyWith(isSelected: false);
          }
        }).toList();

    final updatedProduct = selectedProduct.copyWith(
      alternatives: updatedAlternatives?.cast<Alternatives>(),
    );

    emit(
      state.copyWith(
        selectedProduct: updatedProduct,
        packageModelCopy: state.packageModelCopy!.copyWith(
          products:
              state.packageModelCopy!.products!
                  .map(
                    (product) =>
                        product.id == selectedProduct.id
                            ? updatedProduct
                            : product,
                  )
                  .toList()
                  .cast<Products>(),
        ),
      ),
    );
  }

  void saveChangesForCustomization() {
    emit(
      state.copyWith(
        isSavedChanged: true,
        packageModel: state.packageModelCopy,
        addOnPrice: addOnPrice,
        addOnLength: addOnLength,
        totalPrice:
            double.parse(state.selectedCycle?.price ?? '0.0') + addOnPrice,
      ),
    );
  }

  // When close bottom sheet without save
  void resetSelectedAlternativeAndAddOnPriceWhenCloseBottomSheetWithoutSave() {
    if (state.isSavedChanged == false) {
      emit(
        state.copyWith(
          packageModelCopy: state.packageModel,
          selectedProduct: state.packageModel!.products!.first,
        ),
      );
    } else {
      emit(state.copyWith(isSavedChanged: false));
    }
  }
}
