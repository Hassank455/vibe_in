import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class TextAndDescriptionPackageDetailsBottomSheet extends StatelessWidget {
  final String title;
  const TextAndDescriptionPackageDetailsBottomSheet({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, style: Theme.of(context).textTheme.titleLarge),
        verticalSpace(context, AppSize.s6),
        CustomText(
          text: AppStrings.pleaseSelectOnlyOne.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
        ),
      ],
    ).marginSymmetric(horizontal: context.setWidth(AppSize.s16));
  }
}
