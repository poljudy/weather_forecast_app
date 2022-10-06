/// Custom Exception for the plugin,
/// Thrown whenever the API responds with an error and body could not be parsed.
class OwmApiException implements Exception {
  const OwmApiException(this.code, this.message);

  /// Message about error.
  final String message;

  /// Code api error.
  final int code;

  @override
  String toString() => 'code: $code, message: $message \n${super.toString()}';
}
