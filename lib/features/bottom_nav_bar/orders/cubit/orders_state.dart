 
import 'package:vibe_in/core/helpers/enum.dart';

class OrdersState {
  final RequestsStatus ordersStatus;
  final int currentIndex;
  final String? error;

  const OrdersState({
    this.ordersStatus = RequestsStatus.initial,
    this.currentIndex = 0,
    this.error,
  });

  OrdersState copyWith({
    RequestsStatus? ordersStatus,
    String? error,
    int? currentIndex,
  }) {
    return OrdersState(
      ordersStatus: ordersStatus ?? this.ordersStatus,
      error: error ?? this.error,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
