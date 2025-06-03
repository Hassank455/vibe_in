import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/cubit/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(const OrdersState());

  void changeTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
