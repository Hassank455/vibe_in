import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/banner_home_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/best_seller_widgets/best_seller_home_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/packages_home_widget/packages_home_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/ui/widgets/profile_data_main_widget/profile_data_main_widget.dart';

class MainPageScreen extends StatelessWidget {
  const MainPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(toolbarHeight: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(context, AppSize.s10),
              const ProfileDataMainWidget(),
              verticalSpace(context, AppSize.s20),
              BannerHomeWidget(),
              verticalSpace(context, AppSize.s25),
              BestSellerHomeWidget(),
              verticalSpace(context, AppSize.s25),
              PackagesHomeWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
