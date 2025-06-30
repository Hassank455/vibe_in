import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:vibe_in/features/packages_screen/cubit/packages_cubit.dart';
import 'package:vibe_in/features/packages_screen/cubit/packages_state.dart';
import 'package:vibe_in/features/packages_screen/ui/widgets/loading_packages_screen.dart';
import 'package:vibe_in/features/packages_screen/ui/widgets/success_package_screen.dart';

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
                return LoadingPackagesScreen(
                  height: context.setHeight(AppSize.s305),
                  heightImage: context.setHeight(AppSize.s194),
                );
              } else if (state.packagesState == RequestsStatus.success) {
                return SuccessPackageScreen(
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
}
