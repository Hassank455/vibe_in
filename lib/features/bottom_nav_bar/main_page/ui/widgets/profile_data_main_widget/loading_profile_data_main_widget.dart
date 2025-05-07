import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';

class LoadingProfileDataMainWidget extends StatelessWidget {
  const LoadingProfileDataMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity),
      leading: CustomShimmerWidget(
        width: AppSize.s60.w,
        height: AppSize.s60.h,
        isCircle: true,
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: AppSize.s7.h),
        child: FractionallySizedBox(
          alignment: AlignmentDirectional.centerStart,
          widthFactor: 0.6,
          child: CustomShimmerWidget(
            width: double.infinity,
            height: AppSize.s20.h,
          ),
        ),
      ),
      subtitle: FractionallySizedBox(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: 0.7,
        child: CustomShimmerWidget(
          width: AppSize.s200.w,
          height: AppSize.s20.h,
        ),
      ),
      trailing: CustomShimmerWidget(
        width: AppSize.s48.w,
        height: AppSize.s48.h,
        isCircle: true,
      ),
    );
  }
}
