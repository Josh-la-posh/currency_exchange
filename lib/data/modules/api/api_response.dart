class ApiResponse<T> {
  final T? data;
  final String? message;
  final int? statusCode;
  final bool success;

  ApiResponse({this.data, this.message, this.statusCode, required this.success});

  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse(
      data: data,
      message: message ?? 'Request successful',
      statusCode: statusCode ?? 200,
      success: true,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      data: null,
      message: message,
      statusCode: statusCode ?? 400,
      success: false,
    );
  }
}
