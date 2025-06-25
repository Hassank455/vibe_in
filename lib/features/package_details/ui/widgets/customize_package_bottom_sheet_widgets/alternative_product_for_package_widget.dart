import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_state.dart';

class AlternativeProductForPackageWidget extends StatelessWidget {
  const AlternativeProductForPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: Size(AppSize.s130, AppSize.s233),
      width: context.setMinSize(AppSize.s130),
      height: context.setMinSize(AppSize.s233),
      child: BlocBuilder<PackageDetailsCubit, PackageDetailsState>(
        builder: (context, state) {
          final List<Alternatives>? alternative =
              state.selectedProduct!.alternatives;

          return SizedBox(
            height: context.sizeProvider.height,
            child: ListView.builder(
              itemCount: alternative!.length,
              padding: EdgeInsets.symmetric(
                horizontal: context.setWidth(AppSize.s16),
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: context.sizeProvider.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: context.setHeight(AppSize.s130),
                        width: context.setWidth(AppSize.s130),
                        padding: EdgeInsets.all(
                          context.setMinSize(AppSize.s10),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightestGray,
                          borderRadius: BorderRadius.circular(
                            context.setMinSize(AppSize.s8),
                          ),
                        ),
                        child: CustomCachedNetworkImage(
                          urlImage: alternative[index].image!,
                          height: context.setHeight(AppSize.s130),
                          width: context.setWidth(AppSize.s130),
                          fit: BoxFit.contain,
                        ),
                      ),
                      verticalSpace(context, AppSize.s4),
                      CustomText(
                        text: alternative[index].name,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeightHelper.semiBold,
                          fontSize: context.setSp(AppSize.s12),
                        ),
                      ),
                      verticalSpace(context, AppSize.s7),
                      CustomText(
                        text: 'description',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.gray,
                          fontSize: context.setSp(AppSize.s12),
                        ),
                      ),
                      verticalSpace(context, AppSize.s14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${AppStrings.addOn.tr()}:',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.copyWith(
                                    color: AppColors.gray,
                                    fontSize: context.setSp(AppSize.s11),
                                  ),
                                ),
                                TextSpan(text: ' '),
                                TextSpan(
                                  text: '\$${alternative[index].addOn}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.copyWith(
                                    color: AppColors.mainBrown,
                                    fontSize: context.setSp(AppSize.s11),
                                    fontWeight: FontWeightHelper.semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<PackageDetailsCubit>()
                                  .toggleAlternativeSelection(
                                    alternative[index].id!,
                                  );
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder: (
                                Widget child,
                                Animation<double> animation,
                              ) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child:
                                  alternative[index].isSelected
                                      ? Container(
                                        key: const ValueKey('added'),
                                        height: context.setHeight(AppSize.s31),
                                        width: context.setWidth(AppSize.s31),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.black,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.white,
                                          size: context.setMinSize(AppSize.s24),
                                        ),
                                      )
                                      : Container(
                                        key: const ValueKey('add'),
                                        height: context.setHeight(AppSize.s31),
                                        width: context.setWidth(AppSize.s31),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.mainBrown,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.white,
                                          size: context.setMinSize(AppSize.s24),
                                        ),
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).marginOnly(end: context.setWidth(AppSize.s10)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
