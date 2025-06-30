import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/theming/app_strings.dart';
import 'package:vibe_in/core/theming/font_weight_helper.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/product_details/cubit/product_details_cubit.dart';
import 'package:vibe_in/features/product_details/ui/product_details_bottom_sheet.dart';

class ProductListItemWidget extends StatefulWidget {
  final ProductModel productModel;
  const ProductListItemWidget({super.key, required this.productModel});

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
            return BlocProvider(
              create: (context) => ProductDetailsCubit(widget.productModel),
              child: ProductDetailsBottomSheet(
              
              ),
            );
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
                      urlImage: widget.productModel.images![0],
                      height: AppSize.s146.h,
                      width: AppSize.s146.w,
                      fit: BoxFit.contain,
                      borderNumber: AppSize.s1.r,
                    ),
                  ),
                  if (widget.productModel.label != null)
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
                          text: widget.productModel.label,
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(
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
              text:
                  '${widget.productModel.prices![0].weight!} ${AppStrings.gm.tr()} ',
              maxLines: 1,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColors.gray,
                fontWeight: FontWeightHelper.medium,
              ),
            ),
            verticalSpace(AppSize.s2.h),
            CustomText(
              text: widget.productModel.name,
              maxLines: 1,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontSize: AppSize.s12.sp),
            ),
            verticalSpace(AppSize.s10.h),
            Container(
              padding: EdgeInsetsDirectional.only(
                start: AppSize.s10.w,
                end: AppSize.s4.w,
                top: AppSize.s3.h,
                bottom: AppSize.s3.h,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).cardColor
                        : AppColors.textFiledBackground,

                borderRadius: BorderRadius.circular(AppSize.s20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: '\$${widget.productModel.prices![0].price}',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
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
                                  color: AppColors.mainBrown,
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
                                  color: AppColors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(AppSize.s5.r),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
