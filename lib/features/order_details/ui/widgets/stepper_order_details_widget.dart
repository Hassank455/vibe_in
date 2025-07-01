import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';

class StepperOrderDetailsWidget extends StatelessWidget {
  const StepperOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TimelineStepModel> steps = [
      TimelineStepModel(
        title: 'Ordered',
        date: 'Sun 16 Mar 2025',
        time: '12:37 PM',
        isActive: true,
      ),
      TimelineStepModel(
        title: 'Shipped',
        date: 'Sun 17 Mar 2025',
        time: '12:37 PM',
        isActive: false,
      ),
      TimelineStepModel(
        title: 'Order Arrived',
        date: 'Sun 18 Mar 2025',
        time: '12:37 PM',
        isActive: false,
      ),
    ];

    return Column(
      children: List.generate(
        steps.length,
        (index) => TimelineStepWidget(
          model: steps[index],
          isLast: index == steps.length - 1,
        ),
      ),
    );
  }
}

class TimelineStepWidget extends StatelessWidget {
  final TimelineStepModel model;
  final bool isLast;

  const TimelineStepWidget({
    super.key,
    required this.model,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.setWidth(AppSize.s12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: context.setHeight(AppSize.s12),
                width: context.setWidth(AppSize.s12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      model.isActive
                          ? AppColors.mainBrown
                          : AppColors.strongGray,
                  shape: BoxShape.circle,
                ),
              ),
              verticalSpace(context, AppSize.s5),
              if (!isLast)
                SizedBox(
                  width: context.setWidth(AppSize.s12),
                  child: Container(
                    height: context.setHeight(AppSize.s120),
                    width: context.setWidth(AppSize.s12),
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                      horizontal: context.setWidth(3.5),
                    ),
                    decoration: BoxDecoration(
                      color:
                          model.isActive
                              ? AppColors.mainBrown
                              : AppColors.strongGray.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(
                        context.setMinSize(AppSize.s10),
                      ),
                    ),
                  ),
                ),
              verticalSpace(context, AppSize.s5),
            ],
          ),
        ),
        horizontalSpace(context, AppSize.s10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: model.title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeightHelper.bold,
              ),
            ),
            verticalSpace(context, AppSize.s5),
            CustomText(
              text: model.date,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
            ),
            verticalSpace(context, AppSize.s4),
            CustomText(
              text: model.time,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
            ),
          ],
        ),
      ],
    );
  }
}

class TimelineStepModel {
  final String title;
  final String date;
  final String time;
  final bool isActive;

  TimelineStepModel({
    required this.title,
    required this.date,
    required this.time,
    required this.isActive,
  });
}
