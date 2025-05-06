import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String apiBaseUrl = dotenv.env['API_BASE_URL']!;
  static const String authorization = "Authorization";

}
