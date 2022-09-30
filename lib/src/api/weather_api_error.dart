/// Custom Exception for the plugin,
/// Thrown whenever the API responds with an error and body could not be parsed.
class OwmApiException implements Exception {
  const OwmApiException(this.code, this.cause);

  /// Message about error.
  final String cause;

  /// Code api error.
  final int code;

  @override
  String toString() => '${super.toString()} - code: $code, message: $cause';
}
