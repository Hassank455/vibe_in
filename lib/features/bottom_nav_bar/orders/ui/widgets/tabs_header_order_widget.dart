import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/cubit/orders_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/orders/cubit/orders_state.dart';

class TabsHeaderOrderWidget extends StatelessWidget {
  const TabsHeaderOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersCubit = context.read<OrdersCubit>();
    return BlocSelector<OrdersCubit, OrdersState, int>(
      selector: (state) => state.currentIndex,
      builder: (context, currentIndex) {
        return Container(
          height: context.setHeight(AppSize.s48),
          margin: EdgeInsets.symmetric(
            horizontal: context.setWidth(AppSize.s16),
          ),
          padding: EdgeInsets.all(context.setMinSize(AppSize.s4)),
          decoration: BoxDecoration(
            color: AppColors.textFiledBackground,
            borderRadius: BorderRadius.circular(
              context.setMinSize(AppSize.s30),
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              AnimatedAlign(
                alignment:
                    currentIndex == 0
                        ? AlignmentDirectional.centerStart
                        : currentIndex == 1
                        ? AlignmentDirectional.center
                        : AlignmentDirectional.centerEnd,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  width:
                      MediaQuery.of(context).size.width / 3 -
                      context.setWidth(AppSize.s16) -
                      4, // نصف عرض الـ Container مع حسم الهوامش
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                      context.setMinSize(AppSize.s30),
                    ),
                  ),
                ),
              ),
              Row(
                children: List.generate(3, (index) {
                  final isSelected = index == currentIndex;
                  final label =
                      [
                        AppStrings.all.tr(),
                        AppStrings.pending.tr(),
                        AppStrings.completed.tr(),
                      ][index];
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => ordersCubit.changeTab(index),
                      child: Center(
                        child: CustomText(
                          text: label,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(
                            fontSize: context.setSp(AppSize.s12),
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
