import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text_form_field.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/loading_package_item_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/packages_list_item_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/widgets/filter_bottom_sheet/filter_products_bottom_sheet.dart';

class PackagesTabBarWidget extends StatelessWidget {
  const PackagesTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productsCubit = context.read<ProductsCubit>();
    return Column(
      children: [
        verticalSpace(context, AppSize.s30),
        SizedBox(
          height: context.setHeight(AppSize.s53),
          child: CustomTextFormField(
            controller: productsCubit.searchPackageController,
            validator: (val) {
              return;
            },
            onFieldSubmitted: (p0) {
              productsCubit.refreshPackages();
            },
            hintText: AppStrings.search.tr(),
            prefixIcon: GestureDetector(
              onTap: () {
                productsCubit.refreshPackages();
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: AppSize.s16,
                  end: AppSize.s12,
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
        verticalSpace(context, AppSize.s20),
        BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state.packagesState == RequestsStatus.loading) {
              return buildLoadingWidget();
            } else if (state.packagesState == RequestsStatus.success) {
              return buildSuccessWidget(
                context: context,
                packagesModel: state.packagesModel ?? [],
                isLoadingMore: state.isLoadingMorePackages,
                onEndOfPage:
                    () => productsCubit.refreshPackages(loadMore: true),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    ).marginSymmetric(horizontal: context.setWidth(AppSize.s16));
  }

  Widget buildLoadingWidget() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder:
            (context, index) => LoadingPackageItemWidget(
              height: AppSize.s305,
              heightImage: AppSize.s194,
            ).marginOnly(bottom: context.setHeight(AppSize.s20)),
      ),
    );
  }

  Widget buildSuccessWidget({
    required BuildContext context,
    required List<PackageModel> packagesModel,
    required bool isLoadingMore,
    required VoidCallback onEndOfPage,
  }) {
    return Expanded(
      child: LazyLoadScrollView(
        onEndOfPage: onEndOfPage,
        scrollOffset: 300,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: packagesModel.length + (isLoadingMore ? 2 : 0),
          itemBuilder: (context, index) {
            if (index >= packagesModel.length) {
              return LoadingPackageItemWidget(
                height: AppSize.s305,
                heightImage: AppSize.s194,
              ).marginOnly(bottom: context.setHeight(AppSize.s20));
            }
            return PackagesListItemWidget(
              packageModel: packagesModel[index],
              // height: AppSize.s305,
              heightImage: AppSize.s196,
            ).marginOnly(bottom: context.setHeight(AppSize.s20));
          },
        ),
      ),
    );
  }
}
