import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
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
          constraints: BoxConstraints(minWidth: double.infinity),
          builder: (context) {
            return BlocProvider(
              create: (context) => ProductDetailsCubit(widget.productModel),
              child: ProductDetailsBottomSheet(),
            );
          },
        );
      },
      child: Container(
        height: context.sizeProvider.height,
        width: context.sizeProvider.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.setMinSize(AppSize.s8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: context.setHeight(AppSize.s220),
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).cardColor
                        : AppColors.textFiledBackground,
                borderRadius: BorderRadius.circular(
                  context.setMinSize(AppSize.s8),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: context.setHeight(AppSize.s146),
                    width: context.setWidth(AppSize.s146),
                    child: CustomCachedNetworkImage(
                      urlImage: widget.productModel.images![0],
                      height: context.setHeight(AppSize.s146),
                      width: context.setWidth(AppSize.s146),
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (widget.productModel.label != null)
                    PositionedDirectional(
                      top: context.setHeight(AppSize.s5),
                      end: context.setWidth(AppSize.s5),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.setWidth(AppSize.s13),
                          vertical: context.setHeight(AppSize.s5),
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(
                            context.setMinSize(AppSize.s4),
                          ),
                        ),
                        child: CustomText(
                          text: widget.productModel.label,
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(
                            color: AppColors.white,
                            fontSize: context.setSp(AppSize.s10),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            verticalSpace(context, AppSize.s4),
            CustomText(
              text:
                  '${widget.productModel.prices![0].weight!} ${AppStrings.gm.tr()} ',
              maxLines: 1,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColors.gray,
                fontWeight: FontWeightHelper.medium,
                fontSize: context.setSp(AppSize.s12),
              ),
            ),
            verticalSpace(context, AppSize.s2),
            CustomText(
              text: widget.productModel.name,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: context.setSp(AppSize.s12),
              ),
            ),
            verticalSpace(context, AppSize.s8),
            Container(
              padding: EdgeInsetsDirectional.only(
                start: context.setWidth(AppSize.s10),
                end: context.setWidth(AppSize.s4),
                top: context.setHeight(AppSize.s3),
                bottom: context.setHeight(AppSize.s3),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).cardColor
                        : AppColors.textFiledBackground,
                borderRadius: BorderRadius.circular(
                  context.setMinSize(AppSize.s20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text:
                        '${AppStrings.aed.tr()} ${widget.productModel.prices![0].price}',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: context.setSp(AppSize.s14),
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
                                height: context.setHeight(AppSize.s34),
                                width: context.setWidth(AppSize.s34),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: AppColors.mainBrown,
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
                                height: context.setHeight(AppSize.s34),
                                width: context.setWidth(AppSize.s34),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: AppColors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      context.setMinSize(AppSize.s5),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.white,
                                      size: context.setMinSize(AppSize.s24),
                                    ),
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
