import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_item_shimmer_loading_widget.dart';

class LoadingBestSellerShimmerWidget extends StatelessWidget {
  const LoadingBestSellerShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: AppSize.s10.h,
        crossAxisSpacing: AppSize.s27.w,
        shrinkWrap: true,
        childAspectRatio: 0.5,
        children: List.generate(4, (index) {
          return const ProductItemShimmerLoadingWidget();
        }),
      ),
    );
  }
}
