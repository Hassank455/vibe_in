import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/auth/onboarding/data/models/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  Data onBoardingData;

  OnboardingItem({super.key, required this.onBoardingData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomCachedNetworkImage(
              urlImage: onBoardingData.image!,
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              borderNumber: AppSize.s1.r,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              alignment: AlignmentDirectional.bottomStart,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [
                    0.1,
                    0.1,
                    0.2,
                    0.3,
                    0.4,
                    0.5,
                    0.6,
                    0.7,
                    0.8,
                    0.9,
                    1.0,
                  ],
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                // text: 'Welcome to Vibe In!',
                text: onBoardingData.title,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: AppColors.white),
              ),
              verticalSpace(AppSize.s15),
              CustomText(
                // text: 'Order your favorite coffee with ease and convenience.',
                text: onBoardingData.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.white,
                  fontSize: AppSize.s18.sp,
                ),
              ),
            ],
          ).marginSymmetric(horizontal: AppSize.s16.w),
        ),
      ],
    );
  }
}
