import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/repo/main_page_repo.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/repo/products_repo.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo _productsRepo;
  final MainPageRepo _mainPageRepo;
  ProductsCubit(this._productsRepo, this._mainPageRepo)
    : super(const ProductsState());

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

  final TextEditingController searchProductController = TextEditingController();
  int currentPageProduct = 1;
  bool hasMoreDataProduct = true;

  Future<void> refreshProducts({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasMoreDataProduct || state.isLoadingMoreProduct) return;
      emit(state.copyWith(isLoadingMoreProduct: true));
      currentPageProduct++;
    } else {
      currentPageProduct = 1;
      hasMoreDataPackages = true;
      emit(state.copyWith(productsStatus: RequestsStatus.loading));
    }

    final response = await _productsRepo.getProducts(
      perPage: 10,
      page: currentPageProduct,
      categories: state.selectedCategory,
      search: searchProductController.text,
    );
    if (response.isSuccess) {
      hasMoreDataProduct =
          response.data?.pagination?.currentPage !=
          response.data?.pagination?.lastPage;

      final newProducts = response.data?.data ?? [];
      final allProducts =
          loadMore ? [...?state.productModel, ...newProducts] : newProducts;

      emit(
        state.copyWith(
          productModel: allProducts,
          productsStatus: RequestsStatus.success,
          isLoadingMoreProduct: false,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          error: errorMessage,
          productsStatus: RequestsStatus.error,
          isLoadingMoreProduct: false,
        ),
      );
    }
  }

  int currentPagePackages = 1;
  bool hasMoreDataPackages = true;
  final TextEditingController searchPackageController = TextEditingController();

  Future<void> refreshPackages({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasMoreDataPackages || state.isLoadingMorePackages) return;
      emit(state.copyWith(isLoadingMorePackages: true));
      currentPagePackages++;
    } else {
      resetPackagesWhenSearch();
      emit(state.copyWith(packagesState: RequestsStatus.loading));
    }

    final response = await _mainPageRepo.getPackages(
      perPage: 10,
      page: currentPagePackages,
      search: searchPackageController.text,
    );

    if (response.isSuccess) {
      hasMoreDataPackages =
          response.data?.pagination?.currentPage !=
          response.data?.pagination?.lastPage;

      final newPackages = response.data?.data ?? [];
      final allPackages =
          loadMore ? [...?state.packagesModel, ...newPackages] : newPackages;

      emit(
        state.copyWith(
          packagesModel: allPackages,
          packagesState: RequestsStatus.success,
          isLoadingMorePackages: false,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          error: errorMessage,
          packagesState: RequestsStatus.error,
          isLoadingMorePackages: false,
        ),
      );
    }
  }

  void resetPackagesWhenSearch() {
    currentPagePackages = 1;
    hasMoreDataPackages = true;
    emit(state.copyWith(packagesModel: []));
  }
}
