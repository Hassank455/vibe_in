import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/ui/widgets/order_list_view_item_widget.dart';

class OrderListViewWidget extends StatelessWidget {
  const OrderListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.s16.w,
        vertical: AppSize.s20.h,
      ),
      itemBuilder: (context, index) => OrderListViewItemWidget(),
    );
  }
}
