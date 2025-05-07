import 'package:flutter/material.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageAndAllImagesWidget extends StatelessWidget {
  const ImageAndAllImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCachedNetworkImage(
          urlImage:
              'https://chickchack.s3.eu-west-2.amazonaws.com/customer-dashboard/1744786351349Rectangle_39_1_.png',
          height: AppSize.s305.h,
          width: AppSize.s305.w,
          fit: BoxFit.contain,
          borderNumber: AppSize.s1.r,
        ),
        verticalSpace(AppSize.s15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(
              4,
              (index) => Container(
                height: AppSize.s80.h,
                width: AppSize.s80.w,
                padding: EdgeInsets.all(AppSize.s5.r),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: index == 0 ? AppColors.black : Colors.transparent,
                    width: AppSize.s1.w,
                  ),
                  borderRadius: BorderRadius.circular(AppSize.s8.r),
                ),
                child: CustomCachedNetworkImage(
                  urlImage:
                      'https://chickchack.s3.eu-west-2.amazonaws.com/customer-dashboard/1744786351349Rectangle_39_1_.png',
                  height: AppSize.s71.h,
                  width: AppSize.s71.w,
                  fit: BoxFit.contain,
                  borderNumber: AppSize.s1.r,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
