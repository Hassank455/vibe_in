import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/di/dependency_injection.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/helpers.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_elevation_button.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/cubit/profile_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/cubit/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: 'Profile Screen'),
            verticalSpace(AppSize.s10),
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) async {
                if (state.logoutStatus == RequestsStatus.success) {
                  
                  Helper().showSnackBar(
                    context: context,
                    text: 'Logout successfully',
                  );
                  // await resetAndSetupDependencies();

                  context.pushNamedAndRemoveUntil(
                    Routes.loginScreen,
                    predicate: (route) => false,
                  );
                } else if (state.logoutStatus == RequestsStatus.error) {
                  Helper().showSnackBar(context: context, text: state.error);
                }
              },
              builder: (context, state) {
                return CustomElevatedButton(
                  onTap: () {
                    profileCubit.logout();
                  },
                  title: 'logout',
                  isLoading: state.logoutStatus == RequestsStatus.loading,
                );
              },
            ),
          ],
        ).marginSymmetric(horizontal: AppSize.s16.w),
      ),
    );
  }
}
