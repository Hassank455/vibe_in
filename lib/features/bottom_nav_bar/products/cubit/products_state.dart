import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/models/category_model.dart';

class ProductsState {
  final RequestsStatus categoryStatus;
  final RequestsStatus productsStatus;
  final List<CategoryModel>? categoryModel;
  final List<ProductModel>? productModel;
  final List<int> selectedCategory;
  final int currentIndex;
  final RequestsStatus packagesState;
  final List<PackageModel>? packagesModel;
  final bool isLoadingMoreProduct;
  final bool isLoadingMorePackages;
  final String? error;

  const ProductsState({
    this.categoryStatus = RequestsStatus.initial,
    this.productsStatus = RequestsStatus.initial,
    this.categoryModel,
    this.productModel,
    this.selectedCategory = const [],
    this.currentIndex = 0,
    this.packagesState = RequestsStatus.initial,
    this.packagesModel,
    this.isLoadingMoreProduct = false,
    this.isLoadingMorePackages = false,
    this.error,
  });

  ProductsState copyWith({
    RequestsStatus? categoryStatus,
    RequestsStatus? productsStatus,
    List<CategoryModel>? categoryModel,
    List<ProductModel>? productModel,
    List<int>? selectedCategory,
    int? currentIndex,
    RequestsStatus? packagesState,
    List<PackageModel>? packagesModel,
    bool? isLoadingMoreProduct,
    bool? isLoadingMorePackages,
    String? error,
  }) {
    return ProductsState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      productsStatus: productsStatus ?? this.productsStatus,
      categoryModel: categoryModel ?? this.categoryModel,
      productModel: productModel ?? this.productModel,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      currentIndex: currentIndex ?? this.currentIndex,
      packagesState: packagesState ?? this.packagesState,
      packagesModel: packagesModel ?? this.packagesModel,
      isLoadingMoreProduct: isLoadingMoreProduct ?? this.isLoadingMoreProduct,
      isLoadingMorePackages: isLoadingMorePackages ?? this.isLoadingMorePackages,
      error: error ?? this.error,
    );
  }
}
