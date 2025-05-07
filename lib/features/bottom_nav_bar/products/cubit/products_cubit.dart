import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(const ProductsState());

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
