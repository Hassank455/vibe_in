import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment {
  development,
  staging,
  production,
}

abstract class AppEnvironment {
  static late String baseUrl;
  static late String title;
  static late Environment _environment;

  static Environment get environment => _environment;
  static set environment(Environment value) => _environment = value;

  static setupEnv(Environment env) {
    _environment = env;
    switch (_environment) {
      case Environment.development:
        baseUrl = dotenv.env['API_BASE_URL_DEV']!;
        title = 'Development';
        break;
      case Environment.staging:
        baseUrl = dotenv.env['API_BASE_URL_STAG']!;
        title = 'Staging';
        break;
      case Environment.production:
        baseUrl = dotenv.env['API_BASE_URL']!;
        title = 'Production';
        break;
    }
  }
}
