import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/loading_package_item_widget.dart';

class LoadingPackagesScreen extends StatelessWidget {
  final double height;
  final double heightImage;
  const LoadingPackagesScreen({
    super.key,
    this.height = AppSize.s263,
    this.heightImage = AppSize.s154,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder:
            (context, index) => LoadingPackageItemWidget(
              height: AppSize.s305,
              heightImage: AppSize.s194,
            ).marginOnly(bottom: context.setHeight(AppSize.s20)),
      ),
    );
  }
}
