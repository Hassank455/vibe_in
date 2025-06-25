import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/helpers/responsive_helper/size_provider.dart';
import 'package:vibe_in/core/helpers/responsive_helper/sizer_helper_extension.dart';
import 'package:vibe_in/core/helpers/spacing.dart';
import 'package:vibe_in/core/theming/app_colors.dart';
import 'package:vibe_in/core/theming/app_images.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_image.dart';
import 'package:vibe_in/core/widgets/custom_text.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_cubit.dart';
import 'package:vibe_in/features/package_details/cubit/package_details_state.dart';

class PrimaryProductsForPackageWidget extends StatelessWidget {
  const PrimaryProductsForPackageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final packageDetailsCubit = context.read<PackageDetailsCubit>();
    return SizeProvider(
      baseSize: Size(AppSize.s110, AppSize.s137),
      width: context.setMinSize(AppSize.s110),
      height: context.setMinSize(AppSize.s137),
      child: BlocBuilder<PackageDetailsCubit, PackageDetailsState>(
        builder: (context, state) {
          return SizedBox(
            height: context.sizeProvider.height,
            child: ListView.builder(
              itemCount: state.packageModelCopy!.products!.length,
              padding: EdgeInsets.symmetric(
                horizontal: context.setWidth(AppSize.s16),
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    packageDetailsCubit.changeSelectedProduct(
                      state.packageModelCopy!.products![index],
                    );
                  },
                  child: SizedBox(
                    width: context.sizeProvider.width,
                    height: context.sizeProvider.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.setHeight(AppSize.s110),
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomCachedNetworkImage(
                                urlImage:
                                    state
                                        .packageModelCopy!
                                        .products![index]
                                        .image!,
                                height: context.setHeight(AppSize.s110),
                                width: double.infinity,
                                borderRadius: context.setMinSize(AppSize.s4),
                                fit: BoxFit.contain,
                              ),
                              if (state.selectedProduct!.id ==
                                  state.packageModelCopy!.products![index].id)
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.black.withOpacity(0.8),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        context.setMinSize(AppSize.s4),
                                      ),
                                    ),
                                  ),
                                ),
                              Container(
                                alignment: Alignment.center,
                                width: context.setWidth(AppSize.s42),
                                height: context.setHeight(AppSize.s42),
                                decoration: BoxDecoration(
                                  color:
                                      state.selectedProduct!.id ==
                                              state
                                                  .packageModelCopy!
                                                  .products![index]
                                                  .id
                                          ? AppColors.mainBrown
                                          : AppColors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: CustomSvgImage(
                                  imageName: AppSvgImage.edit,
                                  color: AppColors.white,
                                  height: context.setHeight(AppSize.s18),
                                  width: context.setWidth(AppSize.s18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(context, AppSize.s10),
                        CustomText(
                          text: state.packageModelCopy!.products![index].name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(fontSize: context.setSp(AppSize.s12)),
                        ),
                      ],
                    ),
                  ).marginOnly(end: context.setWidth(AppSize.s10)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
