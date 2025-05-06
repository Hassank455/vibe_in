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
import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';
import 'package:vibe_in/features/auth/login/ui/widgets/button_login_widget.dart';
import 'package:vibe_in/features/auth/login/ui/widgets/phone_login_text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Form(
        key: loginCubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(AppSize.s20),
            CustomText(
              text: AppStrings.welcomeBack.tr(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeightHelper.bold,
              ),
            ),
            verticalSpace(AppSize.s7),
            CustomText(
              text: AppStrings.enterYourMobileNumber.tr(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.gray,
                fontWeight: FontWeightHelper.regular,
              ),
            ),
            verticalSpace(AppSize.s34),
            PhoneLoginTextFieldWidget(),
            verticalSpace(AppSize.s50),
            ButtonLoginWidget(),
          ],
        ).marginSymmetric(horizontal: AppSize.s16.w),
      ).withKey(const Key('login_form')),
    );
  }
}
