import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/core/widgets/custom_text_form_field.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/packages_list_item_widget.dart';
import 'package:vibe_in/features/packages_screen/cubit/packages_cubit.dart';
import 'package:vibe_in/features/packages_screen/cubit/packages_state.dart';
import 'package:vibe_in/features/packages_screen/ui/widgets/loading_packages_screen.dart';

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
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontSize: AppSize.s20.sp),
          ),
          verticalSpaceRemoved(AppSize.s16),
          CustomTextFormField(
            controller: packagesCubit.searchController,
            validator: (val) {
              return;
            },
            onFieldSubmitted: (p0) {
              packagesCubit.getPackages();
            },
            hintText: AppStrings.search.tr(),
            prefixIcon: GestureDetector(
              onTap: () {
                packagesCubit.getPackages();
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: AppSize.s16,
                  end: AppSize.s12,
                ),
                child: CustomSvgImage(
                  imageName: AppSvgImage.search,
                  width: AppSize.s26.w,
                  height: AppSize.s26.h,
                ),
              ),
            ),
          ),
          verticalSpaceRemoved(AppSize.s20),
          BlocBuilder<PackagesCubit, PackagesState>(
            builder: (context, state) {
              if (state.packagesState == RequestsStatus.loading) {
                return LoadingPackagesScreen(
                  height: AppSize.s305,
                  heightImage: AppSize.s194,
                );
              } else if (state.packagesState == RequestsStatus.success) {
                final List<PackageModel>? packagesModel = state.packagesModel;
                final loadingItemCount = 4;
                return Expanded(
                  child: LazyLoadScrollView(
                    onEndOfPage: () => packagesCubit.loadMorePackages(),
                    scrollOffset: 300,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          packagesModel!.length +
                          (state.isLoadingMore ? loadingItemCount : 0),
                      itemBuilder: (context, index) {
                        if (index >= packagesModel.length) {
                          return const LoadingPackagesScreen();
                        }
                        return PackagesListItemWidget(
                          packageModel: packagesModel[index],
                          height: AppSize.s305,
                          heightImage: AppSize.s194,
                        ).marginOnly(bottom: AppSize.s20.h);
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
