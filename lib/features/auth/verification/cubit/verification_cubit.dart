import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/core/helpers/constants.dart';
import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/core/helpers/shared_pref_helper.dart';
import 'package:vibe_in/core/networking/dio_factory.dart';
import 'package:vibe_in/features/auth/login/data/models/login_request_body.dart';
import 'package:vibe_in/features/auth/verification/cubit/verification_state.dart';
import 'package:vibe_in/features/auth/verification/data/model/verification_request_body.dart';
import 'package:vibe_in/features/auth/verification/data/repo/verification_repo.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final VerificationRepo _verificationCodeRepo;
  VerificationCubit(this._verificationCodeRepo) : super(VerificationState()) {
    pinPutFocusNode.requestFocus();
    startTimer();
  }
  late String mobile;
  late String code;

  void init(String phone, String c) {
    mobile = phone;
    code = c;
  }

  @override
  Future<void> close() {
    timer?.cancel();
    pinController.dispose();
    return super.close();
  }

  final pinController = TextEditingController();
  final pinPutFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  otpVerification() async {
    emit(state.copyWith(verificationStatus: RequestsStatus.loading));
    // String? fcmToken = await FirebaseMessaging.instance.getToken();

    final response = await _verificationCodeRepo.checkOTP(
      VerificationRequestBody(
        phone: mobile,
        otp: code,
        fcmToken: 'fcmToken' ?? '',
      ),
    );
    if (response.isSuccess) {
      emit(
        state.copyWith(
          verificationResponse: response.data!,
          verificationStatus: RequestsStatus.success,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          error: errorMessage,
          verificationStatus: RequestsStatus.error,
        ),
      );
    }
  }

  Future<void> saveUserToken(String token) async {
    log('token: $token');
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }

  Timer? timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (state.start == 0) {
        timer.cancel();
        emit(state.copyWith(start: 0));
      } else {
        state.start--;
        emit(state.copyWith(start: state.start));
      }
    });
  }

  String formatTime() {
    final minutes = (state.start ~/ 60).toString().padLeft(2, '0');
    final seconds = (state.start % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void resendCode() async {
    emit(state.copyWith(resendCodeStatus: RequestsStatus.loading));
    final response = await _verificationCodeRepo.resendCode(
      LoginRequestBody(phone: mobile),
    );
    if (response.isSuccess) {
      final resendCodeResponse = response.data;
      code = resendCodeResponse!.data!.otp.toString();
      state.start = 90;
      startTimer();
      emit(
        state.copyWith(
          resendCodeResponse: resendCodeResponse,
          resendCodeStatus: RequestsStatus.success,
        ),
      );
    } else {
      final errorMessage =
          response.errorHandler?.getAllErrorMessages() ?? 'An error occurred';
      emit(
        state.copyWith(
          error: errorMessage,
          resendCodeStatus: RequestsStatus.error,
        ),
      );
    }
  }
}
