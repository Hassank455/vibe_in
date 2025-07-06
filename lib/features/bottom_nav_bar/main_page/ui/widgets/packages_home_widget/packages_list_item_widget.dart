import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/routing/routes.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';

class PackagesListItemWidget extends StatelessWidget {
  final PackageModel packageModel;
  final double heightImage;
  const PackagesListItemWidget({
    super.key,
    required this.packageModel,
    this.heightImage = AppSize.s154,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.packageDetailsScreen,
          arguments: packageModel.id,
        );
      },
      child: Container(
        width: context.sizeProvider.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.setHeight(heightImage),
              width: double.infinity,
              child: CustomCachedNetworkImage(
                urlImage: packageModel.images!.first.url!,
                height: context.setHeight(heightImage),
                width: double.infinity,
                fit: BoxFit.cover,
                borderRadius: context.setMinSize(AppSize.s8),
              ),
            ),
            verticalSpace(context, AppSize.s9),
            CustomText(
              text: packageModel.name,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeightHelper.semiBold,
                fontSize: context.setSp(AppSize.s14),
              ),
            ),
            verticalSpace(context, AppSize.s7),
            CustomText(
              text: packageModel.description,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeightHelper.medium,
                color: AppColors.gray,
                fontSize: context.setSp(AppSize.s12),
              ),
            ),
            verticalSpace(context, AppSize.s7),
          ],
        ),
      ),
    );
  }
}
