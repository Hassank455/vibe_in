import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/repo/main_page_repo.dart';
import 'package:vibe_in/features/packages_screen/cubit/packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  final MainPageRepo _mainPageRepo;
  PackagesCubit(this._mainPageRepo) : super(const PackagesState());
  int currentPage = 1;
  bool hasMoreData = true;
  final TextEditingController searchController = TextEditingController();

  Future<void> refreshPackages({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasMoreData || state.isLoadingMore) return;
      emit(state.copyWith(isLoadingMore: true));
      currentPage++;
    } else {
      currentPage = 1;
      hasMoreData = true;
      emit(state.copyWith(packagesState: RequestsStatus.loading));
    }

    final response = await _mainPageRepo.getPackages(
      perPage: 10,
      page: currentPage,
      search: searchController.text,
    );

    if (response.isSuccess) {
      hasMoreData =
          response.data?.pagination?.currentPage !=
          response.data?.pagination?.lastPage;

      final newPackages = response.data?.data ?? [];
      final allPackages =
          loadMore ? [...?state.packagesModel, ...newPackages] : newPackages;

      emit(
        state.copyWith(
          packagesModel: allPackages,
          packagesState: RequestsStatus.success,
          isLoadingMore: false,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          error: errorMessage,
          packagesState: RequestsStatus.error,
          isLoadingMore: false,
        ),
      );
    }
  }
}
