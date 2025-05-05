import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/cubit/main_page_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/repo/main_page_repo.dart';

class MainPageCubit extends Cubit<MainPageState> {
  final MainPageRepo _mainPageRepo;
  MainPageCubit(this._mainPageRepo) : super(const MainPageState());

  @override
  void emit(MainPageState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> getSliders() async {
    emit(state.copyWith(sliderState: RequestsStatus.loading));
    final response = await _mainPageRepo.getSliders();
    if (response.isSuccess) {
      emit(
        state.copyWith(
          sliderState: RequestsStatus.success,
          sliderModel: response.data,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(error: errorMessage, sliderState: RequestsStatus.error),
      );
    }
  }

  Future<void> getBestSellerProducts() async {
    emit(state.copyWith(bestSellerState: RequestsStatus.loading));
    final response = await _mainPageRepo.getBestSellerProducts(perPage: 10);
    if (response.isSuccess) {
      emit(
        state.copyWith(
          bestSellerState: RequestsStatus.success,
          bestSellerModel: response.data,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          error: errorMessage,
          bestSellerState: RequestsStatus.error,
        ),
      );
    }
  }

  Future<void> getPackages() async {
    emit(state.copyWith(packagesState: RequestsStatus.loading));
    final response = await _mainPageRepo.getPackages(perPage: 10, page: 1);
    if (response.isSuccess) {
      emit(
        state.copyWith(
          packagesState: RequestsStatus.success,
          packagesModel: response.data!.data,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          error: errorMessage,
          packagesState: RequestsStatus.error,
        ),
      );
    }
  }
}
