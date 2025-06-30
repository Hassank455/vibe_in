import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/di/dependency_injection.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/shared_pref_helper.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/cubit/profile_state.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/data/repo/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  ProfileCubit(this._profileRepo) : super(const ProfileState());

  @override
  void emit(ProfileState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  void getProfileData() async {
    emit(state.copyWith(profileStatus: RequestsStatus.loading));
    final response = await _profileRepo.getProfile();
    if (response.isSuccess) {
      emit(
        state.copyWith(
          profileModel: response.data,
          profileStatus: RequestsStatus.success,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          profileStatus: RequestsStatus.error,
          error: errorMessage,
        ),
      );
    }
  }

  void logout() async {
    emit(state.copyWith(logoutStatus: RequestsStatus.loading));
    final response = await _profileRepo.logout();
    if (response.isSuccess) {
      await SharedPrefHelper.clearAllSecuredData();

      emit(state.copyWith(logoutStatus: RequestsStatus.success));
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(logoutStatus: RequestsStatus.error, error: errorMessage),
      );
    }
  }
}
