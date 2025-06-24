import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/loading_package_list_view_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/packages_list_item_widget.dart';

class PackagesHomeWidget extends StatelessWidget {
  const PackagesHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: AppStrings.packages.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: context.setSp(AppSize.s14),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(Routes.packagesScreen);
              },
              child: CustomText(
                text: AppStrings.seeAll.tr(),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppColors.gray),
              ),
            ),
          ],
        ).marginSymmetric(horizontal: context.setWidth(AppSize.s16)),
        verticalSpace(context, AppSize.s12),
        SizeProvider(
          baseSize: Size(AppSize.s284, AppSize.s263),
          width: context.setMinSize(AppSize.s284),
          height: context.setMinSize(AppSize.s263),
          child: BlocBuilder<MainPageCubit, MainPageState>(
            builder: (context, state) {
              if (state.packagesState == RequestsStatus.loading) {
                return LoadingPackageListViewWidget();
              } else if (state.packagesState == RequestsStatus.success) {
                final List<PackageModel> packages = state.packagesModel ?? [];
                return SizedBox(
                  key: const Key('home_loaded'),
                  height: context.sizeProvider.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: packages.length,

                    padding: EdgeInsets.symmetric(
                      horizontal: context.setWidth(AppSize.s16),
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder:
                        (context, index) => PackagesListItemWidget(
                          packageModel: packages[index],
                        ).marginOnly(end: context.setWidth(AppSize.s12)),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
