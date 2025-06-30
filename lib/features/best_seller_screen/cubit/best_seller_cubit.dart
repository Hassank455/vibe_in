import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/best_seller_screen/cubit/best_seller_state.dart';
import 'package:vibe_in/features/best_seller_screen/data/best_seller_repo.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';

class BestSellerCubit extends Cubit<BestSellerState> {
  final BestSellerRepo _bestSellerRepo;
  BestSellerCubit(this._bestSellerRepo) : super(const BestSellerState());

  int currentPage = 1;
  bool hasMoreData = true;
  Future<void> getBestSellerProducts() async {
    emit(state.copyWith(bestSellerState: RequestsStatus.loading));
    final response = await _bestSellerRepo.getBestSellerProducts(
      perPage: 10,
      page: currentPage,
    );
    if (response.isSuccess) {
      hasMoreData =
          response.data?.pagination?.currentPage !=
          response.data?.pagination?.lastPage;
      emit(
        state.copyWith(
          bestSellerState: RequestsStatus.success,
          bestSellerModel: response.data?.data ?? [],
        ),
      );
    } else {
      emitError(response);
    }
  }

  Future<void> loadMoreProducts() async {
    if (!hasMoreData || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    try {
      currentPage++;
      final response = await _bestSellerRepo.getBestSellerProducts(
        perPage: 10,
        page: currentPage,
      );

      if (response.isSuccess) {
        final List<ProductModel> newProducts = response.data?.data ?? [];
        final List<ProductModel> allProducts = [
          ...state.bestSellerModel ?? [],
          ...newProducts,
        ];
        hasMoreData =
            response.data?.pagination?.currentPage !=
            response.data?.pagination?.lastPage;

        emit(
          state.copyWith(
            bestSellerModel: allProducts,
            bestSellerState: RequestsStatus.success,
            isLoadingMore: false,
          ),
        );
      } else {
        emitError(response);
      }
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  void emitError(response) {
    final errorMessage =
        response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
    emit(
      state.copyWith(
        error: errorMessage,
        bestSellerState: RequestsStatus.error,
        isLoadingMore: false,
      ),
    );
  }
}
