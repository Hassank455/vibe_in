import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/core/widgets/custom_text_form_field.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/packages_list_item_widget.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppStrings.packages.tr(),
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontSize: AppSize.s20.sp),
          ),
          verticalSpace(AppSize.s16),
          CustomTextFormField(
            controller: TextEditingController(),
            validator: (val) {},
            hintText: AppStrings.search.tr(),
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: AppSize.s16,
                end: AppSize.s12,
              ),
              child: CustomSvgImage(
                imageName: AppSvgImage.search,
                width: AppSize.s26.w,
                height: AppSize.s26.h,
              ),
            ),
          ),

          verticalSpace(AppSize.s20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder:
                  (context, index) => const PackagesListItemWidget(
                    height: AppSize.s305,
                    heightImage: AppSize.s194,
                  ).marginOnly(bottom: AppSize.s20.h),
            ),
          ),
        ],
      ).marginSymmetric(horizontal: AppSize.s16.w),
    );
  }
}
