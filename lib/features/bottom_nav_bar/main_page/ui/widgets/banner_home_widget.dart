import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/extensions.dart';
import 'package:vibe_in/core/theming/app_size.dart';
import 'package:vibe_in/core/widgets/custom_cached_network_image.dart';
import 'package:vibe_in/core/widgets/custom_shimmer_widget.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/slider_model.dart';

class BannerHomeWidget extends StatelessWidget {
  const BannerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageCubit, MainPageState>(
      builder: (context, state) {
        if (state.sliderState == RequestsStatus.loading) {
          return CustomShimmerWidget(
            width: double.infinity,
            height: AppSize.s194.h,
          );
        } else if (state.sliderState == RequestsStatus.success) {
          List<SliderModel>? sliderModel = state.sliderModel!;
          return SizedBox(
            height: AppSize.s194.h,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: sliderModel.length,
              itemBuilder:
                  (context, index, _) => CustomCachedNetworkImage(
                    urlImage: sliderModel[index].image!,
                    height: AppSize.s194.h,
                    width: double.infinity,
                    borderNumber: AppSize.s8.r,
                    fit: BoxFit.fill,
                  ),
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {},
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    ).marginSymmetric(horizontal: AppSize.s16.w);
  }
}
