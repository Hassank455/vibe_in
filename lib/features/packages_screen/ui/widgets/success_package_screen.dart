import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/packages_list_item_widget.dart';
import 'package:vibe_in/features/packages_screen/ui/widgets/loading_packages_screen.dart';

class SuccessPackageScreen extends StatelessWidget {
  final List<PackageModel> packagesModel;
  final bool isLoadingMore;
  final VoidCallback onEndOfPage;
  const SuccessPackageScreen({
    super.key,
    required this.packagesModel,
    required this.isLoadingMore,
    required this.onEndOfPage,
  });
  static const _loadingItemCount = 4;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LazyLoadScrollView(
        onEndOfPage: onEndOfPage,
        scrollOffset: 300,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              packagesModel.length + (isLoadingMore ? _loadingItemCount : 0),
          itemBuilder: (context, index) {
            if (index >= packagesModel.length) {
              return const LoadingPackagesScreen();
            }
            return PackagesListItemWidget(
              packageModel: packagesModel[index],
              height: context.setHeight(AppSize.s305),
              heightImage: context.setHeight(AppSize.s194),
            ).marginOnly(bottom: context.setHeight(AppSize.s20));
          },
        ),
      ),
    );
  }
}
