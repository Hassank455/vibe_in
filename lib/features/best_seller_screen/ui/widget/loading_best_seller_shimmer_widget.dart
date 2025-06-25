import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/device_utils.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_item_shimmer_loading_widget.dart';

class LoadingBestSellerShimmerWidget extends StatelessWidget {
  const LoadingBestSellerShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: DeviceUtils.valueDecider<int>(
            context,
            onMobile: 2,
            others: 3,
          ),
          mainAxisSpacing: context.setMinSize(AppSize.s10),
          crossAxisSpacing: context.setMinSize(AppSize.s27),
          childAspectRatio:
              context.isLandscape
                  ? DeviceUtils.valueDecider<double>(
                    context,
                    onMobile: 1.1,
                    others: 0.75,
                  )
                  : DeviceUtils.valueDecider<double>(
                    context,
                    onMobile: 0.5,
                    others: 0.54,
                  ),
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return const ProductItemShimmerLoadingWidget();
        },
      ),
    );
  }
}
