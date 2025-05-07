import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_cubit.dart';

class PinputOtpWidget extends StatelessWidget {
  const PinputOtpWidget({super.key});

  PinTheme defaultPinTheme(context) {
    return PinTheme(
      width: AppSize.s60.w,
      height: AppSize.s56.h,
      textStyle: Theme.of(context).textTheme.titleMedium!,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSize.s8.r),
        border: Border.all(color: AppColors.lightGray, width: 1.w),
      ),
    );
  }

  PinTheme focusedPinTheme(context) {
    return PinTheme(
      width: AppSize.s60.w,
      height: AppSize.s56.h,
      textStyle: Theme.of(context).textTheme.titleMedium!,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSize.s8.r),
        border: Border.all(color: AppColors.mainBrown, width: 1.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final verificationCodeCubit = context.read<VerificationCubit>();
    return Center(
      child: Pinput(
        key: const Key('otp_field'),
        controller: verificationCodeCubit.pinController,
        focusNode: verificationCodeCubit.pinPutFocusNode,
        length: 4,
        validator: (value) {
          if (verificationCodeCubit.code != value) {
            return AppStrings.otpMismatch.tr();
          }
          return null;
        },
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        defaultPinTheme: defaultPinTheme(context),
        focusedPinTheme: focusedPinTheme(context),
        onCompleted: (pin) {
          if (verificationCodeCubit.code ==
              verificationCodeCubit.pinController.text) {
            verificationCodeCubit.otpVerification();
          }
        },
      ),
    ).marginSymmetric(horizontal: AppSize.s16.w);
  }
}
