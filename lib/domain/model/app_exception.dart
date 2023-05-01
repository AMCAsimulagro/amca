class AppException implements Exception {
  final String? message;
  final String? codeError;
  final int? status;

  AppException({
    this.message,
    this.codeError,
    this.status,
  });
}