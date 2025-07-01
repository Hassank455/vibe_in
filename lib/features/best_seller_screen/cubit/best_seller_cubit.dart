import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/best_seller_screen/cubit/best_seller_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/repo/main_page_repo.dart';

class BestSellerCubit extends Cubit<BestSellerState> {
  final MainPageRepo _mainPageRepo;
  BestSellerCubit(this._mainPageRepo) : super(const BestSellerState());

  int currentPage = 1;
  bool hasMoreData = true;

  Future<void> refreshBestSellerProducts({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasMoreData || state.isLoadingMore) return;
      emit(state.copyWith(isLoadingMore: true));
      currentPage++;
    } else {
      currentPage = 1;
      hasMoreData = true;
      emit(state.copyWith(bestSellerStatus: RequestsStatus.loading));
    }

    // 2️⃣ نداء الـ API
    final response = await _mainPageRepo.getBestSellerProducts(
      perPage: 10,
      page: currentPage,
    );

    if (response.isSuccess) {
      hasMoreData =
          response.data?.pagination?.currentPage !=
          response.data?.pagination?.lastPage;

      final newProducts = response.data?.data ?? [];
      final allProducts =
          loadMore ? [...?state.bestSellerModel, ...newProducts] : newProducts;

      emit(
        state.copyWith(
          bestSellerModel: allProducts,
          bestSellerStatus: RequestsStatus.success,
          isLoadingMore: false,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          error: errorMessage,
          bestSellerStatus: RequestsStatus.error,
          isLoadingMore: false,
        ),
      );
    }
  }
}
