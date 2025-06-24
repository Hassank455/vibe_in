import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/loading_package_item_widget.dart';

class LoadingPackageListViewWidget extends StatelessWidget {
  const LoadingPackageListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sizeProvider.height,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
        padding: EdgeInsets.symmetric(
          horizontal: context.setWidth(AppSize.s16),
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder:
            (context, index) => LoadingPackageItemWidget().marginOnly(
              end: context.setWidth(AppSize.s12),
            ),
      ),
    );
  }
}
