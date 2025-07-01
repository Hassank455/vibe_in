import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/product_details/cubit/product_details_cubit.dart';
import 'package:vibe_in/features/product_details/cubit/product_details_state.dart';

class ImageAndAllImagesWidget extends StatelessWidget {
  const ImageAndAllImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = context.read<ProductDetailsCubit>();
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final productDetailsCubit = context.read<ProductDetailsCubit>();
        final images = productDetailsCubit.product.images!;
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomCachedNetworkImage(
                    urlImage: state.imageSelected ?? '',
                    height: context.setHeight(AppSize.s305),
                    width: context.setWidth(AppSize.s305),
                    fit: BoxFit.contain,
                  ),
                  if (productDetailsCubit.product.label != null)
                    PositionedDirectional(
                      top: context.setHeight(AppSize.s5),
                      end: context.setWidth(AppSize.s5),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.setWidth(AppSize.s15),
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
                          text: productDetailsCubit.product.label,
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
            verticalSpace(context, AppSize.s15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => GestureDetector(
                  onTap: () => productDetailsCubit.changeCurrentImage(index),
                  child: Container(
                    height: context.setHeight(AppSize.s80),
                    width: context.setWidth(AppSize.s80),
                    margin: EdgeInsets.symmetric(
                      horizontal: context.setWidth(AppSize.s5),
                    ),
                    padding: EdgeInsets.all(context.setMinSize(AppSize.s5)),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            index == state.currentIndex
                                ? AppColors.black
                                : Colors.transparent,
                        width: context.setWidth(AppSize.s1),
                      ),
                      borderRadius: BorderRadius.circular(
                        context.setMinSize(AppSize.s8),
                      ),
                    ),
                    child: CustomCachedNetworkImage(
                      urlImage: images[index],
                      height: context.setHeight(AppSize.s71),
                      width: context.setWidth(AppSize.s71),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
