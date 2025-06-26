import 'dart:ui'; // For BackdropFilter

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class Helper {
  void showSnackBar({
    required BuildContext context,
    required String? text,
    bool error = false,
    Color? color,
    String? actionTitle,
    Function()? onPressed,
  }) {
    // Using ScaffoldMessenger to show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        backgroundColor: Colors.transparent, // Make the background transparent
        elevation: 0, // Remove shadow
        content: Stack(
          children: [
            // Blurred background using BackdropFilter
            ClipRRect(
              borderRadius: BorderRadius.circular(
                context.setMinSize(AppSize.s10),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  height: context.setHeight(AppSize.s45),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(
                      0.4,
                    ), // Adjust opacity for visibility
                    borderRadius: BorderRadius.circular(
                      context.setMinSize(AppSize.s10),
                    ),
                  ),
                ),
              ),
            ),
            // SnackBar content
            Positioned.fill(
              child: Center(
                child: CustomText(
                  text: text ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.only(
          right: context.setWidth(AppSize.s20),
          left: context.setWidth(AppSize.s20),
          bottom:
              MediaQuery.of(context).size.height -
              (context.setHeight(AppSize.s190)),
        ),
      ),
    );
  }

  void snackBarAddToCart(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSize.s8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightGreen,
              ),
              child: const Icon(Icons.check, color: AppColors.white),
            ),
            horizontalSpace(context, AppSize.s10),
            CustomText(
              text: AppStrings.addToCartSuccessfully.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: context.setSp(AppSize.s14),
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: context.setHeight(AppSize.s8),
                horizontal: context.setWidth(AppSize.s18),
              ),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(
                  context.setMinSize(AppSize.s4),
                ),
              ),
              child: CustomText(
                text: AppStrings.viewCart.tr(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: context.setSp(AppSize.s12),
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.white,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        ),
        // padding: EdgeInsets.all(15),
      ),
    );
  }
}
