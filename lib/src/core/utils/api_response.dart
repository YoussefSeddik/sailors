class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final Map<String, List<String>>? errors;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.errors,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json)? fromJsonT,
      ) {
    return ApiResponse<T>(
      success: json['success'] ?? json['value'] ?? false,
      message: json['message'] ?? json['msg'],
      data: fromJsonT != null && json['data'] != null
          ? fromJsonT(json['data'])
          : null,
      errors: _parseErrors(json['errors']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (message != null) 'message': message,
      if (data != null) 'data': (data as dynamic).toJson(),
      if (errors != null) 'errors': errors,
    };
  }

  static Map<String, List<String>>? _parseErrors(dynamic raw) {
    if (raw is Map) {
      return raw.map((key, value) => MapEntry(
        key.toString(),
        List<String>.from(value as List),
      ));
    }
    return null;
  }
}
