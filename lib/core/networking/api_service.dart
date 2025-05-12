import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vibe_in/core/networking/api_constants.dart';
import 'package:vibe_in/core/networking/generic_api_response.dart';
import 'package:vibe_in/features/auth/login/data/models/login_request_body.dart';
import 'package:vibe_in/features/auth/login/data/models/login_response.dart';
import 'package:vibe_in/features/auth/onboarding/data/models/onboarding_model.dart';
import 'package:vibe_in/features/auth/verification/data/model/verification_request_body.dart';
import 'package:vibe_in/features/auth/verification/data/model/verification_response.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/product_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/slider_model.dart';
import 'package:vibe_in/features/bottom_nav_bar/profile/data/models/profile_model.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.checkOtp)
  Future<VerificationResponse> checkOTP(
    @Body() VerificationRequestBody verificationRequestBody,
  );

  @GET(ApiConstants.onboarding)
  Future<OnboardingModel> getOnboarding();

  @POST(ApiConstants.logout)
  Future<dynamic> logout();

  @GET(ApiConstants.sliders)
  Future<ApiResponse<List<SliderModel>>> getSliders();

  @GET(ApiConstants.profile)
  Future<ProfileModel> getProfile();

  @GET(ApiConstants.bestSellerProducts)
  Future<ApiResponse<List<ProductModel>>> getBestSellerProducts(
    @Query('per_page') int? perPage,
    @Query('page') int? page,
  );

  @GET(ApiConstants.packages)
  Future<ApiResponse<List<PackageModel>>> getPackages(
    @Query('per_page') int? perPage,
    @Query('page') int? page,
    @Query('search') String? search,
  );
}
