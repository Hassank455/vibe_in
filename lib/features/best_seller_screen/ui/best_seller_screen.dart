import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/best_seller_screen/cubit/best_seller_cubit.dart';
import 'package:vibe_in/features/best_seller_screen/cubit/best_seller_state.dart';
import 'package:vibe_in/features/best_seller_screen/ui/widget/best_seller_grid_widget.dart';
import 'package:vibe_in/features/best_seller_screen/ui/widget/loading_best_seller_shimmer_widget.dart';

class BestSellerScreen extends StatelessWidget {
  const BestSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BestSellerCubit bestSellerCubit = context.read<BestSellerCubit>();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppStrings.bestSeller.tr(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: context.setSp(AppSize.s20),
            ),
          ),
          verticalSpace(context, AppSize.s20),
          BlocBuilder<BestSellerCubit, BestSellerState>(
            builder: (context, state) {
              if (state.bestSellerStatus == RequestsStatus.loading) {
                return LoadingBestSellerShimmerWidget();
              } else if (state.bestSellerStatus == RequestsStatus.success) {
                return BestSellerGridWidget(
                  products: state.bestSellerModel ?? [],
                  isLoadingMore: state.isLoadingMore,
                  onEndOfPage:
                      () => bestSellerCubit.refreshBestSellerProducts(
                        loadMore: true,
                      ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ).marginSymmetric(horizontal: context.setWidth(AppSize.s16)),
    );
  }
}
