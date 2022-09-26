/// Custom Exception for the plugin,
/// Thrown whenever the API responds with an error and body could not be parsed.
class OpenWeatherAPIException implements Exception {
  const OpenWeatherAPIException(this._cause);

  final String _cause;

  @override
  String toString() => '${super.toString()} - $_cause';
}
