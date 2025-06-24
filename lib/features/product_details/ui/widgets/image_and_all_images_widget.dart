import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image_removed.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  CustomCachedNetworkImageRemoved(
                    urlImage: state.imageSelected ?? '',
                    height: AppSize.s305.h,
                    width: AppSize.s305.w,
                    fit: BoxFit.contain,
                    borderNumber: AppSize.s1.r,
                  ),
                  if (productDetailsCubit.product.label != null)
                    PositionedDirectional(
                      top: AppSize.s5.h,
                      end: AppSize.s5.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.s15.w,
                          vertical: AppSize.s5.h,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(AppSize.s4.r),
                        ),
                        child: CustomText(
                          text: productDetailsCubit.product.label,
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
            verticalSpaceRemoved(AppSize.s15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => GestureDetector(
                  onTap: () => productDetailsCubit.changeCurrentImage(index),
                  child: Container(
                    height: AppSize.s80.h,
                    width: AppSize.s80.w,
                    margin: EdgeInsets.symmetric(horizontal: AppSize.s5.w),
                    padding: EdgeInsets.all(AppSize.s5.r),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            index == state.currentIndex
                                ? AppColors.black
                                : Colors.transparent,
                        width: AppSize.s1.w,
                      ),
                      borderRadius: BorderRadius.circular(AppSize.s8.r),
                    ),
                    child: CustomCachedNetworkImageRemoved(
                      urlImage: images[index],
                      height: AppSize.s71.h,
                      width: AppSize.s71.w,
                      fit: BoxFit.contain,
                      borderNumber: AppSize.s1.r,
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
