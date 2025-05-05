import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/product_details/cubit/product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductModel product;

  ProductDetailsCubit(this.product)
    : super(
        ProductDetailsState(
          imageSelected: product.images![0],
          currentIndex: 0,
          selectedPriceIndex: 0,
          selectedQuantity: 1, // start with 1
        ),
      );

  void changeCurrentImage(int index) {
    emit(
      state.copyWith(
        imageSelected: product.images![index],
        currentIndex: index,
      ),
    );
  }

  void selectPriceIndex(int index) {
    emit(
      state.copyWith(
        selectedPriceIndex: index,
        selectedQuantity: 1, // reset quantity to 1 when selecting new price
      ),
    );
  }

  void increaseQuantity() {
    emit(state.copyWith(selectedQuantity: state.selectedQuantity + 1));
  }

  void decreaseQuantity() {
    if (state.selectedQuantity > 1) {
      emit(state.copyWith(selectedQuantity: state.selectedQuantity - 1));
    }
  }
}
