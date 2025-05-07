import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class ItemFilterBottomSheet extends StatelessWidget {
  const ItemFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.textFiledBackground,
        borderRadius: BorderRadius.circular(AppSize.s6.r),
      ),
      child: CustomText(
        text: 'Coffee',
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontSize: AppSize.s12.sp),
      ),
    );
  }
}
