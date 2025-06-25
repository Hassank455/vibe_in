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

class ContentsPackageWidget extends StatelessWidget {
  const ContentsPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final updatedProducts =
        context.read<PackageDetailsCubit>().state.packageModelCopy?.products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppStrings.contents.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontWeight: FontWeightHelper.medium),
        ),
        verticalSpace(context, AppSize.s12),
        SizeProvider(
          baseSize: Size(AppSize.s80, AppSize.s120),
          width: context.setMinSize(AppSize.s80),
          height: context.setMinSize(AppSize.s120),
          child: Builder(
            builder: (context) {
              return SizedBox(
                height: context.sizeProvider.height,
                child: ListView.builder(
                  itemCount: updatedProducts?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final product = updatedProducts![index];

                    Alternatives? selectedAlternative;
                    try {
                      selectedAlternative = product.alternatives?.firstWhere(
                        (alt) => alt.isSelected,
                      );
                    } catch (e) {
                      selectedAlternative = null;
                    }

                    final displayName =
                        selectedAlternative?.name ?? product.name;
                    final displayImage =
                        selectedAlternative?.image ?? product.image;
                    return SizedBox(
                      width: context.sizeProvider.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: context.setHeight(AppSize.s80),
                            width: context.sizeProvider.width,
                            padding: EdgeInsets.all(
                              context.setWidth(AppSize.s5),
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Theme.of(context).cardColor
                                      : AppColors.lightestGray,
                              borderRadius: BorderRadius.circular(
                                context.setMinSize(AppSize.s8),
                              ),
                            ),
                            child: CustomCachedNetworkImage(
                              urlImage: displayImage!,
                              height: context.setHeight(AppSize.s70),
                              width: context.setWidth(AppSize.s70),
                              fit: BoxFit.contain,
                            ),
                          ),
                          verticalSpace(context, AppSize.s4),
                          CustomText(
                            text: displayName,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeightHelper.medium,
                              fontSize: context.setSp(AppSize.s12),
                            ),
                          ),
                        ],
                      ).marginOnly(end: context.setWidth(AppSize.s10)),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
