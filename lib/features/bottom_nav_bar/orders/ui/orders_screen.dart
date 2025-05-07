import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/cubit/orders_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/cubit/orders_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/ui/widgets/order_list_view_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/ui/widgets/tabs_header_order_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        title: CustomText(
          text: AppStrings.orders.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s48.h),
          child: TabsHeaderOrderWidget(),
        ),
      ),

      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, selectedIndex) {
          if (selectedIndex.currentIndex == 0) {
            return OrderListViewWidget();
          } else if (selectedIndex.currentIndex == 1) {
            return OrderListViewWidget();
          } else {
            return OrderListViewWidget();
          }
        },
      ),
    );
  }
}
