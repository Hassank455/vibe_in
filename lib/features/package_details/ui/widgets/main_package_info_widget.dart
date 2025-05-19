import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';

class MainPackageInfoWidget extends StatelessWidget {
  final PackageModel package;
  const MainPackageInfoWidget({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCachedNetworkImage(
          urlImage: package.images!.first.url!,
          height: AppSize.s196.h,
          width: double.infinity,
          borderNumber: AppSize.s8.r,
          // fit: BoxFit.contain,
        ),
        verticalSpace(AppSize.s16),
        CustomText(
          text: package.name,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontSize: AppSize.s18.sp),
        ),
        verticalSpace(AppSize.s10),
        CustomText(
          text: '\$${package.price}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: AppSize.s22.sp,
            color: AppColors.mainBrown,
          ),
        ),
      ],
    );
  }
}
