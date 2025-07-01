import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:vibe_in/core/helpers/responsive_helper/device_utils.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_item_shimmer_loading_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_list_item_widget.dart';

class BestSellerGridWidget extends StatelessWidget {
  final List<ProductModel> products;
  final bool isLoadingMore;
  final VoidCallback onEndOfPage;
  const BestSellerGridWidget({
    super.key,
    required this.products,
    required this.isLoadingMore,
    required this.onEndOfPage,
  });

  static const _loadingItemCount = 4;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LazyLoadScrollView(
        onEndOfPage: onEndOfPage,
        scrollOffset: 300,
        child: SizeProvider(
          baseSize: Size(context.screenWidth, AppSize.s222),
          width: context.screenWidth,
          height: context.setMinSize(AppSize.s222),
          child: Builder(
            builder: (context) {
              return GridView.builder(
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
                            onMobile: 0.52,
                            onTablet: 0.5,
                            onDesktop: 0.55,
                          ),
                ),
                itemCount:
                    products.length + (isLoadingMore ? _loadingItemCount : 0),
                itemBuilder: (context, index) {
                  if (index >= products.length) {
                    return const ProductItemShimmerLoadingWidget();
                  }
                  return ProductListItemWidget(productModel: products[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
