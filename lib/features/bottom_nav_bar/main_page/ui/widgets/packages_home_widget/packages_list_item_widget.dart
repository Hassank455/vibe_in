import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class PackagesListItemWidget extends StatelessWidget {
  final double height;
  final double heightImage;
  const PackagesListItemWidget({
    super.key,
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
              urlImage:
                  'https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&w=1200',
              height: heightImage.h,
              width: double.infinity,
              fit: BoxFit.cover,
              borderNumber: AppSize.s8.r,
            ),
          ),
          verticalSpace(AppSize.s9),
          CustomText(
            text: 'Elite Nuts & Fruits Set',
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeightHelper.semiBold,
            ),
          ),
          verticalSpace(AppSize.s7),
          CustomText(
            text:
                'Dried Apricots Dried Cherries or Cranberries Chocolate Almonds',
            maxLines: 2,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: AppSize.s12.sp,
              color: AppColors.gray,
            ),
          ),
          verticalSpace(AppSize.s7),
          CustomText(
            text: '120.0\$',
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
