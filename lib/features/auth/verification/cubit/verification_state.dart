import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/auth/login/data/models/login_response.dart';
import 'package:vibe_in/features/auth/verification/data/model/verification_response.dart';

final class ChangeTimeState extends VerificationState {}

class VerificationState {
  final RequestsStatus verificationStatus;
  final RequestsStatus resendCodeStatus;
  final LoginResponse? resendCodeResponse;
  final VerificationResponse? verificationResponse;
  int start;
  final String? error;

  VerificationState({
    this.verificationStatus = RequestsStatus.initial,
    this.resendCodeStatus = RequestsStatus.initial,
    this.verificationResponse,
    this.resendCodeResponse,
    this.start = 90,
    this.error,
  });

  VerificationState copyWith({
    RequestsStatus? verificationStatus,
    RequestsStatus? resendCodeStatus,
    VerificationResponse? verificationResponse,
    LoginResponse? resendCodeResponse,
    int? start,
    String? error,
  }) {
    return VerificationState(
      verificationStatus: verificationStatus ?? this.verificationStatus,
      resendCodeStatus: resendCodeStatus ?? this.resendCodeStatus,
      verificationResponse: verificationResponse ?? this.verificationResponse,
      resendCodeResponse: resendCodeResponse ?? this.resendCodeResponse,
      start: start ?? this.start,
      error: error ?? this.error,
    );
  }
}
