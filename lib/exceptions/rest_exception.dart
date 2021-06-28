class RestException implements Exception {
  final String message;

  const RestException(this.message);
  String toString() => "RestException: $message";
}
