import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image_removed.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';

class MainPackageInfoWidget extends StatelessWidget {
  final PackageModel package;
  const MainPackageInfoWidget({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCachedNetworkImageRemoved(
          urlImage: package.images!.first.url!,
          height: AppSize.s196.h,
          width: double.infinity,
          borderNumber: AppSize.s8.r,
          // fit: BoxFit.contain,
        ),
        verticalSpaceRemoved(AppSize.s16),
        CustomText(
          text: package.name,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontSize: AppSize.s18.sp),
        ),
        verticalSpaceRemoved(AppSize.s10),
        CustomText(
          text:
              '${AppStrings.aed.tr()} ${context.read<PackageDetailsCubit>().state.totalPrice}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: AppSize.s22.sp,
            color: AppColors.mainBrown,
          ),
        ),
      ],
    );
  }
}
