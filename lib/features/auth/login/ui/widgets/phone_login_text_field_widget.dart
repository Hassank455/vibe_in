import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/core/widgets/custom_text_form_field.dart';
import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';
import 'package:vibe_in/features/auth/login/cubit/login_state.dart';

class PhoneLoginTextFieldWidget extends StatelessWidget {
  const PhoneLoginTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final fieldError =
            (state is ErrorLoginState)
                ? state.fieldErrors['phone']?.join('\n')
                : null;

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
            if (fieldError != null) return fieldError;
            return null;
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(9),
            FilteringTextInputFormatter.digitsOnly,
          ],
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              horizontalSpace(context, AppSize.s10),
              CustomSvgImage(
                imageName: AppSvgImage.sa,
                width: context.setWidth(AppSize.s36),
                height: context.setHeight(AppSize.s24),
              ),
              horizontalSpace(context, AppSize.s10),
              CustomText(
                text: '+966',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: context.setSp(AppSize.s12),
                ),
              ),
              horizontalSpace(context, AppSize.s10),
            ],
          ),
          hintText: AppStrings.mobileNumber.tr(),
        );
      },
    );
  }
}
