import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_cubit.dart';
import 'package:vibe_in/features/auth/verification/ui/widget/button_and_resend_otp_widget.dart';
import 'package:vibe_in/features/auth/verification/ui/widget/pinput_otp_widget.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final verificationCodeCubit = context.read<VerificationCubit>();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(AppSize.s20),
          CustomText(
            text: AppStrings.verificationCode.tr(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeightHelper.bold,
            ),
          ),
          verticalSpace(AppSize.s7),
          CustomText(
            text: AppStrings.weSentATemporaryLoginCode.tr(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.gray,
              fontWeight: FontWeightHelper.regular,
            ),
          ),
          verticalSpace(AppSize.s12),
          CustomText(
            text: '+966 ${verificationCodeCubit.mobile}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          verticalSpace(AppSize.s40),
          PinputOtpWidget(),
          verticalSpace(AppSize.s56),
          ButtonAndResendOtpWidget(),
        ],
      ).marginSymmetric(horizontal: AppSize.s16.w),
    );
  }
}
