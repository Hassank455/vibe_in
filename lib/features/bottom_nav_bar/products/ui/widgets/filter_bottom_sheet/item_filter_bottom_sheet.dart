import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
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
        borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s6)),
      ),
      child: CustomText(
        text: 'Coffee',
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(fontSize: context.setSp(AppSize.s12)),
      ),
    );
  }
}
