import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/widgets/custom_app_bar.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_cubit.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/cubit/home_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/home/ui/widget/custom_nav_bottom.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => previous != current,
        builder:
            (context, state) => Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: CustomAppBar(
                toolbarHeight: homeCubit.indexScreen == 3 ? 0 : 10,
                systemOverlayStyle:
                    homeCubit.indexScreen == 3
                        ? Theme.of(
                          context,
                        ).appBarTheme.systemOverlayStyle!.copyWith(
                          statusBarIconBrightness: Brightness.dark,
                          statusBarBrightness: Brightness.dark,
                        )
                        : null,
              ),
              extendBody: true,
              extendBodyBehindAppBar: homeCubit.indexScreen == 3 ? true : false,
              bottomNavigationBar: const CustomNavBottom(),
              body: IndexedStack(
                index: homeCubit.indexScreen!,
                children: homeCubit.widgetOptions,
              ),
            ),
      ),
    );
  }
}
