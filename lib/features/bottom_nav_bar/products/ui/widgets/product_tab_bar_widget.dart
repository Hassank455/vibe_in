import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:vibe_in/core/di/dependency_injection.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/device_utils.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/core/widgets/custom_text_form_field.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_item_shimmer_loading_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/product_list_item_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/widgets/filter_bottom_sheet/filter_products_bottom_sheet.dart';

class ProductTabBarWidget extends StatelessWidget {
  const ProductTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productsCubit = context.read<ProductsCubit>();
    return Column(
      children: [
        verticalSpace(context, AppSize.s30),
        SizedBox(
          height: context.setHeight(AppSize.s53),
          child: Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: productsCubit.searchProductController,
                  validator: (val) {
                    return;
                  },
                  onFieldSubmitted: (val) {
                    productsCubit.refreshProducts();
                  },
                  hintText: AppStrings.search.tr(),
                  prefixIcon: GestureDetector(
                    onTap: () {
                      productsCubit.refreshProducts();
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: context.setWidth(AppSize.s16),
                        end: context.setWidth(AppSize.s12),
                      ),
                      child: CustomSvgImage(
                        imageName: AppSvgImage.search,
                        width: context.setWidth(AppSize.s26),
                        height: context.setHeight(AppSize.s26),
                      ),
                    ),
                  ),
                ),
              ),
              horizontalSpace(context, AppSize.s5),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    constraints: BoxConstraints(minWidth: double.infinity),
                    isScrollControlled: true,
                    builder: (context) {
                      return BlocProvider.value(
                        value: productsCubit,
                        child: FilterProductsBottomSheet(),
                      );
                    },
                  );
                },
                child: Container(
                  width: context.setWidth(AppSize.s48),
                  height: context.setHeight(AppSize.s48),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.setWidth(AppSize.s13),
                    vertical: context.setHeight(AppSize.s12),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textFiledBackground,
                    borderRadius: BorderRadius.circular(
                      context.setMinSize(AppSize.s8),
                    ),
                  ),
                  child: CustomSvgImage(
                    imageName: AppSvgImage.setting,
                    width: context.setWidth(AppSize.s24),
                    height: context.setHeight(AppSize.s24),
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(context, AppSize.s20),
        SizeProvider(
          baseSize: Size(context.screenWidth, AppSize.s313),
          width: context.screenWidth,
          height: context.setMinSize(AppSize.s313),
          child: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state.productsStatus == RequestsStatus.loading) {
                return buildLoadingProduct(context);
              } else if (state.productsStatus == RequestsStatus.success) {
                return buildSuccessProduct(
                  context: context,
                  products: state.productModel ?? [],
                  isLoadingMore: state.isLoadingMoreProduct,
                  onEndOfPage:
                      () => productsCubit.refreshProducts(loadMore: true),
                );
              } else {
                return Center(child: CustomText(text: state.error));
              }
            },
          ),
        ),
      ],
    ).marginSymmetric(horizontal: context.setWidth(AppSize.s16));
  }

  Widget buildLoadingProduct(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: DeviceUtils.valueDecider<int>(
          context,
          onMobile: 2,
          others: 3,
        ),
        mainAxisSpacing: context.setHeight(AppSize.s20),
        crossAxisSpacing: context.setWidth(AppSize.s27),
        shrinkWrap: true,
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
        children: List.generate(
          6,
          (index) => ProductItemShimmerLoadingWidget(),
        ),
      ),
    );
  }

  Widget buildSuccessProduct({
    required BuildContext context,
    required List<ProductModel> products,
    required bool isLoadingMore,
    required VoidCallback onEndOfPage,
  }) {
    return Expanded(
      child: LazyLoadScrollView(
        onEndOfPage: onEndOfPage,
        scrollOffset: 300,
        child: GridView.count(
          crossAxisCount: DeviceUtils.valueDecider<int>(
            context,
            onMobile: 2,
            others: 3,
          ),
          mainAxisSpacing: context.setHeight(AppSize.s20),
          crossAxisSpacing: context.setWidth(AppSize.s27),
          shrinkWrap: true,
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
          children: List.generate(
            products.length + (isLoadingMore ? AppSize.loadingItemCount : 0),
            (index) {
              if (index >= products.length) {
                return const ProductItemShimmerLoadingWidget();
              }
              return ProductListItemWidget(productModel: products[index]);
            },
          ),
        ),
      ),
    );
  }
}
