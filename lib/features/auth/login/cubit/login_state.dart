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
  final Map<String, List<String>> fieldErrors;
  ErrorLoginState({this.error, this.fieldErrors = const {}});
}

class ChangeIsValidState extends LoginState {}
