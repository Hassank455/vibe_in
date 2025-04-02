import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final bool? status;
  final int? code;
  final String? message;
  final dynamic data;

  ApiErrorModel({
    this.status,
    this.code,
    this.message,
    required this.data,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  /// Returns a String containing all the error messages
  String getAllErrorMessages() {
    if (data == null || data is List && (data as List).isEmpty) {
      return data ?? "Unknown Error occurred";
    }

    // TODO : explain this new update
    if (data is Map<String, dynamic>) {
      final errorMessage =
          (data as Map<String, dynamic>).entries.map((entry) {
        final value = entry.value;
        return "${value.join(',')}";
      }).join('\n');

      return errorMessage;
    } else if (data is List) {
      return (data as List).join('\n');
    }

    return data ?? "Unknown Error occurred";
  }
}