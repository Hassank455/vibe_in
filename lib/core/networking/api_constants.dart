import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String apiBaseUrl = dotenv.env['API_BASE_URL']!;
  //static final String apiBaseUrl = dotenv.env['API_BASE_URL_DEV']!;
  static const String authorization = "Authorization";

  static const String login = "mobile/send-otp";
  static const String checkOtp = "mobile/verify-otp";
  static const String onboarding = "mobile/onbording";
  static const String logout = "mobile/logout";
  static const String sliders = "mobile/sliders";
  static const String profile = "mobile/profile";
  static const String bestSellerProducts = "mobile/products/best/";
  static const String packages = "mobile/packages";
}
