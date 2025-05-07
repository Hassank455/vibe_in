import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/product_details/ui/product_details_bottom_sheet.dart';

class ProductListItemWidget extends StatefulWidget {
  const ProductListItemWidget({super.key});

  @override
  State<ProductListItemWidget> createState() => _ProductListItemWidgetState();
}

class _ProductListItemWidgetState extends State<ProductListItemWidget>
    with SingleTickerProviderStateMixin {
  bool _isAdded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleAdd() {
    setState(() {
      _isAdded = !_isAdded;
    });
    if (_isAdded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return ProductDetailsBottomSheet();
          },
        );
      },
      child: Container(
        height: AppSize.s320.h,
        width: AppSize.s168.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: AppSize.s220.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).cardColor
                        : AppColors.textFiledBackground,
                borderRadius: BorderRadius.circular(AppSize.s8.r),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: AppSize.s146.h,
                    width: AppSize.s146.w,
                    child: CustomCachedNetworkImage(
                      urlImage:
                          'https://chickchack.s3.eu-west-2.amazonaws.com/customer-dashboard/1744786351349Rectangle_39_1_.png',
                      height: AppSize.s146.h,
                      width: AppSize.s146.w,
                      fit: BoxFit.contain,
                      borderNumber: AppSize.s1.r,
                    ),
                  ),
                  PositionedDirectional(
                    top: AppSize.s5.h,
                    end: AppSize.s5.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.s13.w,
                        vertical: AppSize.s5.h,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(AppSize.s4.r),
                      ),
                      child: CustomText(
                        text: AppStrings.new1.tr(),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.white,
                          fontSize: AppSize.s10.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(AppSize.s4.h),
            CustomText(
              text: 'Dolce Gusto',
              maxLines: 1,
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(color: AppColors.gray),
            ),
            verticalSpace(AppSize.s2.h),
            CustomText(
              text: 'Brilliance Yumberry Red Natural...',
              maxLines: 2,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontSize: AppSize.s12.sp),
            ),
            verticalSpace(AppSize.s2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: '120.0\$',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s16.sp,
                    color: AppColors.mainBrown,
                  ),
                ),
                GestureDetector(
                  onTap: _toggleAdd,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child:
                        _isAdded
                            ? Container(
                              key: const ValueKey('added'),
                              height: AppSize.s34.h,
                              width: AppSize.s34.w,
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: AppColors.white,
                              ),
                            )
                            : Container(
                              key: const ValueKey('add'),
                              height: AppSize.s34.h,
                              width: AppSize.s34.w,
                              decoration: BoxDecoration(
                                color: AppColors.mainBrown,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(AppSize.s5.r),
                                child: Icon(Icons.add, color: AppColors.white),
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
