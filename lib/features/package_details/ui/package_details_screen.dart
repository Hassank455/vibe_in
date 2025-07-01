import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_state.dart';
import 'package:vibe_in/features/package_details/ui/widgets/contents_package_widget.dart';
import 'package:vibe_in/features/package_details/ui/widgets/customize_and_add_to_cart_widget.dart';
import 'package:vibe_in/features/package_details/ui/widgets/loading_shimmer_package_details_widget.dart';
import 'package:vibe_in/features/package_details/ui/widgets/main_package_info_widget.dart';
import 'package:vibe_in/features/package_details/ui/widgets/monthly_cycles_package_widget.dart';

class PackageDetailsScreen extends StatelessWidget {
  const PackageDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final packageDetailsCubit = context.read<PackageDetailsCubit>();

    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomizeAndAddToCartWidget(
        packageDetailsCubit: packageDetailsCubit,
      ),
      body: BlocBuilder<PackageDetailsCubit, PackageDetailsState>(
        builder: (context, state) {
          if (state.packageState == RequestsStatus.loading) {
            return const LoadingShimmerPackageDetailsWidget();
          } else if (state.packageState == RequestsStatus.success) {
            final PackageModel package = state.packageModel!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainPackageInfoWidget(package: package),
                  verticalSpace(context, AppSize.s10),
                  MonthlyCyclesPackageWidget(),
                  verticalSpace(context, AppSize.s20),
                  ContentsPackageWidget(),
                  verticalSpace(context, AppSize.s20),
                  CustomText(
                    text: AppStrings.description.tr(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeightHelper.medium,
                    ),
                  ),
                  verticalSpace(context, AppSize.s12),
                  CustomText(
                    text: package.description,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ).marginSymmetric(horizontal: context.setWidth(AppSize.s16)),
    );
  }
}
