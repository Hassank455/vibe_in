import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/core/widgets/custom_text_form_field.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/loading_package_item_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/packages_list_item_widget.dart';
import 'package:vibe_in/features/packages_screen/cubit/packages_cubit.dart';
import 'package:vibe_in/features/packages_screen/cubit/packages_state.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final packagesCubit = context.read<PackagesCubit>();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppStrings.packages.tr(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: context.setSp(AppSize.s20),
            ),
          ),
          verticalSpace(context, AppSize.s16),
          CustomTextFormField(
            controller: packagesCubit.searchController,
            validator: (val) {
              return;
            },
            onFieldSubmitted: (p0) {
              packagesCubit.refreshPackages();
            },
            hintText: AppStrings.search.tr(),
            prefixIcon: GestureDetector(
              onTap: () {
                packagesCubit.refreshPackages();
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
          verticalSpace(context, AppSize.s20),
          BlocBuilder<PackagesCubit, PackagesState>(
            builder: (context, state) {
              if (state.packagesState == RequestsStatus.loading) {
                return buildLoadingWidget();
              } else if (state.packagesState == RequestsStatus.success) {
                return buildSuccessWidget(
                  context: context,
                  packagesModel: state.packagesModel ?? [],
                  isLoadingMore: state.isLoadingMore,
                  onEndOfPage:
                      () => packagesCubit.refreshPackages(loadMore: true),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ).marginSymmetric(horizontal: context.setWidth(AppSize.s16)),
    );
  }

  Widget buildLoadingWidget() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
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
          itemCount:
              packagesModel.length +
              (isLoadingMore ? AppSize.loadingItemCount : 0),
          itemBuilder: (context, index) {
            if (index >= packagesModel.length) {
              return LoadingPackageItemWidget(
              height: AppSize.s305,
              heightImage: AppSize.s194,
            ).marginOnly(bottom: context.setHeight(AppSize.s20));
            }
            return PackagesListItemWidget(
              packageModel: packagesModel[index],
              heightImage: context.setHeight(AppSize.s194),
            ).marginOnly(bottom: context.setHeight(AppSize.s20));
          },
        ),
      ),
    );
  }
}
