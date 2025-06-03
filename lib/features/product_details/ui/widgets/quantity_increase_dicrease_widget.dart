import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

// ignore: must_be_immutable
class QuantityIncreaseDecreaseWidget extends StatelessWidget {
  final GestureTapCallback? onTapDecrease;
  final GestureTapCallback? onTapIncrease;
  final String quantity;

  final bool canEdit;
  final Color backgroundColor;

  QuantityIncreaseDecreaseWidget({
    super.key,
    required this.onTapDecrease,
    required this.onTapIncrease,
    required this.quantity,
    this.canEdit = true,
   required this.backgroundColor ,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTapDecrease,
          borderRadius: BorderRadius.circular(AppSize.s9.r),
          child: Container(
            padding: EdgeInsets.all(AppSize.s6),
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            child: Icon(Icons.remove),
          ),
        ),
        horizontalSpace(AppSize.s10),
        IntrinsicWidth(
          child: CustomText(
            text: quantity.toString(),
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontSize: AppSize.s16.sp),
          ),
        ),
        horizontalSpace(AppSize.s10),
        InkWell(
          onTap: onTapIncrease,
          borderRadius: BorderRadius.circular(AppSize.s9.r),
          child: Container(
            padding: EdgeInsets.all(AppSize.s6.r),
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
