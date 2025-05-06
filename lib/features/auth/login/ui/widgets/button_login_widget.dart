import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/helpers.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/features/auth/login/cubit/login_cubit.dart';
import 'package:vibe_in/features/auth/login/cubit/login_state.dart';

class ButtonLoginWidget extends StatelessWidget {
  const ButtonLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is SuccessLoginState) {
          context.pushNamed(
            Routes.verificationScreen,
            arguments: {
              'phone': loginCubit.phoneController.text,
              'code': state.loginResponse.data!.otp,
            },
          );
        } else if (state is ErrorLoginState) {
          Helper().showSnackBar(context: context, text: state.error);
        }
      },
      builder: (context, state) {
        return Hero(
          tag: 'login_button',
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            return ScaleTransition(
              scale: animation,
              child: toHeroContext.widget,
            );
          },
          child: CustomElevatedButton(
            key: Key('login_button_click'),
            onTap: () {
              if (loginCubit.formKey.currentState!.validate()) {
                loginCubit.emitLoginStates();
              }
            },
            isLoading: state is LoadingLoginState,
            title: AppStrings.continueText.tr(),
          ),
        );
      },
    );
  }
}
