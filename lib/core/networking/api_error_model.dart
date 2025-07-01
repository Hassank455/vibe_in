import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final bool? status;
  final int? code;
  final String? message;
  final dynamic data;

  ApiErrorModel({this.status, this.code, this.message, required this.data});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String getAllErrorMessages() {
    if (data == null) return "Unknown Error occurred";

    if (data is Map<String, dynamic>) {
      try {
        return data.entries
            .map((entry) {
              final value = entry.value;

              if (value is List) {
                return value.map((e) => e.toString()).join(', ');
              } else if (value is String) {
                return value;
              } else {
                return value.toString();
              }
            })
            .join('\n');
      } catch (e) {
        return "Unknown Error occurred";
      }
    } else if (data is List) {
      return data.map((e) => e.toString()).join('\n');
    } else if (data is String) {
      return data;
    }

    return "Unknown Error occurred";
  }
}
