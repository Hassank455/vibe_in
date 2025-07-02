import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/repo/products_repo.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo _productsRepo;

  ProductsCubit(this._productsRepo) : super(const ProductsState());

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  Future<void> getCategories() async {
    emit(state.copyWith(categoryStatus: RequestsStatus.loading));
    final response = await _productsRepo.getCategories();
    if (response.isSuccess) {
      emit(
        state.copyWith(
          categoryStatus: RequestsStatus.success,
          categoryModel: response.data?.data ?? [],
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          error: errorMessage,
          categoryStatus: RequestsStatus.error,
        ),
      );
    }
  }

  void selectCategory(int catId) {
    if (state.selectedCategory.contains(catId)) {
      final updatedList =
          state.selectedCategory.where((element) => element != catId).toList();
      emit(state.copyWith(selectedCategory: updatedList));
    } else {
      final updatedList = [...state.selectedCategory, catId];
      emit(state.copyWith(selectedCategory: updatedList));
    }
  }

  void resetCategories() {
    emit(state.copyWith(selectedCategory: []));
  }
}
