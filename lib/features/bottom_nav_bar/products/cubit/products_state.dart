import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/data/models/category_model.dart';

class ProductsState {
  final RequestsStatus categoryStatus;
  final RequestsStatus productsStatus;
  final List<CategoryModel>? categoryModel;
  final List<int> selectedCategory;
  final int currentIndex;
  final String? error;

  const ProductsState({
    this.categoryStatus = RequestsStatus.initial,
    this.productsStatus = RequestsStatus.initial,
    this.categoryModel,
    this.selectedCategory = const [],
    this.currentIndex = 0,
    this.error,
  });

  ProductsState copyWith({
    RequestsStatus? categoryStatus,
    RequestsStatus? productsStatus,
    List<CategoryModel>? categoryModel,
    List<int>? selectedCategory,
    String? error,
    int? currentIndex,
  }) {
    return ProductsState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      productsStatus: productsStatus ?? this.productsStatus,
      categoryModel: categoryModel ?? this.categoryModel,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      error: error ?? this.error,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
