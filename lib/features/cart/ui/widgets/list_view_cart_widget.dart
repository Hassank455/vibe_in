import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/features/cart/ui/widgets/item_list_view_cart_widget.dart';

class ListViewCartWidget extends StatelessWidget {
  const ListViewCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder:
            (context, index) =>
                ItemListViewCartWidget().marginOnly(bottom: AppSize.s20.h),
      ),
    );
  }
}
