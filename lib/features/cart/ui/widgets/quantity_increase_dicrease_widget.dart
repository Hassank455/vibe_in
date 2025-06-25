import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

// ignore: must_be_immutable
class QuantityIncreaseDecreaseWidget extends StatelessWidget {
  final GestureTapCallback? onTapDecrease;
  final GestureTapCallback? onTapIncrease;
  final String quantity;

  final bool canEdit;
  final Color backgroundColor;

  const QuantityIncreaseDecreaseWidget({
    super.key,
    required this.onTapDecrease,
    required this.onTapIncrease,
    required this.quantity,
    this.canEdit = true,
    required this.backgroundColor,
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
          borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s9)),
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
        horizontalSpace(context, AppSize.s10),
        IntrinsicWidth(
          child: CustomText(
            text: quantity.toString(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: context.setSp(AppSize.s16),
            ),
          ),
        ),
        horizontalSpace(context, AppSize.s10),
        InkWell(
          onTap: onTapIncrease,
          borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s9)),
          child: Container(
            padding: EdgeInsets.all(context.setMinSize(AppSize.s6)),
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
