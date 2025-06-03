import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/main_page_screen.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/ui/orders_screen.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/products_screen.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/ui/profile_screen.dart';
import 'package:vibe_in/features/bottom_nav_bar/scan_screen/ui/scan_screen.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    indexScreen = 0;
  }

  List<Widget> widgetOptions = const <Widget>[
    MainPageScreen(),
    ProductsScreen(),
    ScanScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  int? indexScreen;

  setIndexScreen(int value) {
    indexScreen = value;
    HapticFeedback.vibrate();
    emit(ChangeIndexScreen());
  }
}
