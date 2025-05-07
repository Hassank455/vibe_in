import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/data/models/profile_model.dart';

class ProfileState {
  final RequestsStatus profileStatus;
  final RequestsStatus logoutStatus;
  final ProfileModel? profileModel;
  final String? error;

  const ProfileState({
    this.profileStatus = RequestsStatus.initial,
    this.logoutStatus = RequestsStatus.initial,
    this.profileModel,
    this.error,
  });

  ProfileState copyWith({
    RequestsStatus? profileStatus,
    RequestsStatus? logoutStatus,
    ProfileModel? profileModel,
    String? error,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      profileModel: profileModel ?? this.profileModel,
      error: error ?? this.error,
    );
  }
}
