/// {@category Domain}
///This class represents an application exception, which can be thrown to indicate errors
///that occur during the execution of the application. It provides properties to store
///information about the exception, such as message, error code, and status.
library;


class AppException implements Exception {
  final String? message;
  final String? codeError;
  final int? status;

  /// Constructs an instance of [AppException] with optional parameters:
  /// [message], [codeError], and [status].
  AppException({
    this.message,
    this.codeError,
    this.status,
  });
}