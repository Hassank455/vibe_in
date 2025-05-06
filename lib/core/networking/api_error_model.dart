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

  /// Returns a String containing all the error messages
  // String getAllErrorMessages() {
  //   if (data == null || data is List && (data as List).isEmpty) {
  //     return data ?? "Unknown Error occurred";
  //   }

  //   // TODO : explain this new update
  //   if (data is Map<String, dynamic>) {
  //     final errorMessage =
  //         (data as Map<String, dynamic>).entries.map((entry) {
  //       final value = entry.value;
  //       return "${value.join(',')}";
  //     }).join('\n');

  //     return errorMessage;
  //   } else if (data is List) {
  //     return (data as List).join('\n');
  //   }

  //   return data ?? "Unknown Error occurred";
  // }
  String getAllErrorMessages() {
    print('📦 getAllErrorMessages called with data: $data');
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
        print('❌ Error in map logic: $e');
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
