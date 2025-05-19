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
}
