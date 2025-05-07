import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          height: AppSize.s48.h,
          margin: EdgeInsets.symmetric(horizontal: AppSize.s16.w),
          padding: EdgeInsets.all(AppSize.s4.r),
          decoration: BoxDecoration(
            color: AppColors.textFiledBackground,
            borderRadius: BorderRadius.circular(AppSize.s30.r),
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
                      AppSize.s16.w -
                      4, // نصف عرض الـ Container مع حسم الهوامش
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
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
                            fontSize: AppSize.s12.sp,
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
