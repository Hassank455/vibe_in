import 'package:vibe_in/features/auth/login/data/models/login_response.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final LoginResponse loginResponse;
  SuccessLoginState(this.loginResponse);
}

class ErrorLoginState extends LoginState {
  String? error;
  ErrorLoginState({this.error});
}

class ChangeIsValidState extends LoginState {}

