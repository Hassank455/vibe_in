import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';

class PackagesListItemWidget extends StatelessWidget {
  final PackageModel packageModel;
  final double height;
  final double heightImage;
  const PackagesListItemWidget({
    super.key,
    required this.packageModel,
    this.height = AppSize.s263,
    this.heightImage = AppSize.s154,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: AppSize.s284.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: heightImage.h,
            width: double.infinity,
            child: CustomCachedNetworkImage(
              urlImage: packageModel.images!.first.url!,
              height: heightImage.h,
              width: double.infinity,
              fit: BoxFit.cover,
              borderNumber: AppSize.s8.r,
            ),
          ),
          verticalSpace(AppSize.s9),
          CustomText(
            text: packageModel.name,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeightHelper.semiBold,
            ),
          ),
          verticalSpace(AppSize.s7),
          CustomText(
            text: packageModel.description,
            maxLines: 2,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: AppSize.s12.sp,
              color: AppColors.gray,
            ),
          ),
          verticalSpace(AppSize.s7),
          CustomText(
            text: '${packageModel.price}\$',
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: AppSize.s16.sp,
              color: AppColors.mainBrown,
            ),
          ),
        ],
      ),
    );
  }
}
