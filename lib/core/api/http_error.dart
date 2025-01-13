class HttpError implements Exception {
  final String message;
  final String error;
  final int? statusCode;

  HttpError(this.statusCode, this.error, this.message);

  @override
  String toString() => "HttpError: $message";
}
