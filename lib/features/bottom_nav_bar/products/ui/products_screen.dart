import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/cubit/products_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/widgets/packages_tab_bar_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/widgets/product_tab_bar_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/products/ui/widgets/tabs_header_products_widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
        title: CustomText(
          text: AppStrings.products.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(context.setHeight(AppSize.s48)),
          child: TabsHeaderProductsWidget(),
        ),
      ),

      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, selectedIndex) {
          if (selectedIndex.currentIndex == 0) {
            return ProductTabBarWidget();
          } else {
            return PackagesTabBarWidget();
          }
        },
      ),
    );
  }
}
