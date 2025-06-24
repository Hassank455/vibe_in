import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/best_seller_screen/cubit/best_seller_cubit.dart';
import 'package:vibe_in/features/best_seller_screen/cubit/best_seller_state.dart';
import 'package:vibe_in/features/best_seller_screen/ui/widget/loading_best_seller_shimmer_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_item_shimmer_loading_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_list_item_widget.dart';

class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BestSellerCubit bestSellerCubit = context.read<BestSellerCubit>();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppStrings.bestSeller.tr(),
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontSize: AppSize.s20.sp),
          ),
          verticalSpaceRemoved(AppSize.s20),
          BlocBuilder<BestSellerCubit, BestSellerState>(
            builder: (context, state) {
              if (state.bestSellerState == RequestsStatus.loading) {
                return LoadingBestSellerShimmerWidget();
              } else if (state.bestSellerState == RequestsStatus.success) {
                final products = state.bestSellerModel ?? [];
                final loadingItemCount = 4;

                return Expanded(
                  child: LazyLoadScrollView(
                    onEndOfPage: () => bestSellerCubit.loadMoreProducts(),
                    scrollOffset: 300,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSize.s10.h,
                        crossAxisSpacing: AppSize.s27.w,
                        childAspectRatio: 0.5,
                      ),
                      itemCount:
                          products.length +
                          (state.isLoadingMore ? loadingItemCount : 0),
                      itemBuilder: (context, index) {
                        if (index >= products.length) {
                          return const ProductItemShimmerLoadingWidget();
                        }
                        return ProductListItemWidget(
                          productModel: products[index],
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ).marginSymmetric(horizontal: AppSize.s16.w),
    );
  }
}
