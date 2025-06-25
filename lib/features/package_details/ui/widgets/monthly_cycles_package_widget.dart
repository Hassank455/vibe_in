import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';

class MonthlyCyclesPackageWidget extends StatelessWidget {
  const MonthlyCyclesPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final packageDetailsCubit = context.read<PackageDetailsCubit>();
    final cycles = packageDetailsCubit.state.packageModel!.cycles;
    final selectedCycle = packageDetailsCubit.state.selectedCycle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: AppStrings.numberOfMonthlyCycles.tr(),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeightHelper.medium,
            color: AppColors.gray,
          ),
        ),
        verticalSpace(context, AppSize.s16),
        SizeProvider(
          baseSize: Size(AppSize.s76, AppSize.s32),
          width: context.setMinSize(AppSize.s76),
          height: context.setMinSize(AppSize.s32),
          child: Builder(
            builder: (context) {
              return SizedBox(
                height: context.sizeProvider.height,
                child: ListView.builder(
                  itemCount: cycles!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: context.sizeProvider.width,
                      child: GestureDetector(
                        onTap: () {
                          packageDetailsCubit.changeSelectedCycle(
                            cycles[index],
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: context.setWidth(AppSize.s8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: context.setWidth(AppSize.s10),
                            vertical: context.setHeight(AppSize.s6),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              context.setMinSize(AppSize.s36),
                            ),
                            border: Border.all(
                              color:
                                  selectedCycle?.id == cycles[index].id
                                      ? AppColors.mainBrown
                                      : AppColors.lightGray,

                              width: context.setWidth(AppSize.s1),
                            ),
                          ),
                          child: CustomText(
                            text: cycles[index].name,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeightHelper.semiBold,
                              fontSize: context.setSp(AppSize.s12),
                              color:
                                  selectedCycle?.id == cycles[index].id
                                      ? AppColors.mainBrown
                                      : null,
                            ),
                          ),
                        ),
                      ),
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
