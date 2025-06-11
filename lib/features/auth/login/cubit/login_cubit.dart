import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_in/features/auth/login/cubit/login_state.dart';
import 'package:vibe_in/features/auth/login/data/models/login_request_body.dart';
import 'package:vibe_in/features/auth/login/data/repo/login_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginInitial());

  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  void emitLoginStates() async {
    emit(LoadingLoginState());
    final response = await _loginRepo.login(
      LoginRequestBody(phone: phoneController.text),
    );
    if (response.isSuccess) {
      emit(SuccessLoginState(response.data!));
    } else {
      final errorModel = response.errorHandler;
      final errorMessage =
          errorModel?.getAllErrorMessages() ?? 'An error occurred';
      Map<String, List<String>> fieldErrors = {};

      if (errorModel?.data is Map<String, dynamic>) {
        fieldErrors = (errorModel!.data as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, List<String>.from(value)),
        );
      }

      emit(ErrorLoginState(error: errorMessage, fieldErrors: fieldErrors));
    }
  }
}
