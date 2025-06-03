import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/core/widgets/custom_text_form_field.dart';
import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';

class PhoneLoginTextFieldWidget extends StatelessWidget {
  const PhoneLoginTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return CustomTextFormField(
      key: Key('phone_field'),
      controller: loginCubit.phoneController,
      keyboardType: TextInputType.number,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return AppStrings.pleaseEnterYourMobileNumber.tr();
        }
        if (val.length != 9) {
          return AppStrings.mobileNumberMustBe9Digits.tr();
        }
        if (!val.startsWith('5')) {
          return AppStrings.mobileNumberMustStartWith5.tr();
        }
        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(9),
        FilteringTextInputFormatter.digitsOnly,
      ],
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          horizontalSpace(AppSize.s10),
          CustomSvgImage(
            imageName: AppSvgImage.sa,
            width: AppSize.s36.w,
            height: AppSize.s24.h,
          ),
          horizontalSpace(AppSize.s10),
          CustomText(
            text: '+966',
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontSize: AppSize.s12.sp),
          ),
          horizontalSpace(AppSize.s10),
        ],
      ),
      hintText: AppStrings.mobileNumber.tr(),
    );
  }
}
