import 'package:json_annotation/json_annotation.dart';
part 'verification_request_body.g.dart';

@JsonSerializable()
class VerificationRequestBody {
  final String phone;
  final String otp;
  @JsonKey(name: 'fcm_token')
  final String fcmToken;

  VerificationRequestBody(
      {required this.phone, required this.otp, required this.fcmToken});

  Map<String, dynamic> toJson() => _$VerificationRequestBodyToJson(this);
}