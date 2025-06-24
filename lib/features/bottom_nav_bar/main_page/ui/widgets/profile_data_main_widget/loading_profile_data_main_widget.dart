import 'package:flutter/material.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';

class LoadingProfileDataMainWidget extends StatelessWidget {
  const LoadingProfileDataMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity),
      leading: CustomShimmerWidget(
        height: context.setHeight(AppSize.s60),
        width: context.setWidth(AppSize.s60),
        isCircle: true,
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: context.setHeight(AppSize.s7)),
        child: FractionallySizedBox(
          alignment: AlignmentDirectional.centerStart,
          widthFactor: 0.6,
          child: CustomShimmerWidget(
            width: double.infinity,
            height: context.setHeight(AppSize.s20),
          ),
        ),
      ),
      subtitle: FractionallySizedBox(
        alignment: AlignmentDirectional.centerStart,
        widthFactor: 0.7,
        child: CustomShimmerWidget(
          width: context.setWidth(AppSize.s200),
          height: context.setHeight(AppSize.s20),
        ),
      ),
      trailing: CustomShimmerWidget(
        width: context.setWidth(AppSize.s48),
        height: context.setHeight(AppSize.s48),
        isCircle: true,
      ),
    );
  }
}
