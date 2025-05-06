import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vibe_in/core/networking/api_constants.dart';
import 'package:vibe_in/features/auth/onboarding/data/models/onboarding_model.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;



  @GET(ApiConstants.onboarding)
  Future<OnboardingModel> getOnboarding();

}
