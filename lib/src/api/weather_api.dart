import '../utils/languages.dart';

/// Uri builder class for the OpenWeatherMap API
class OpenWeatherMapAPI {
  OpenWeatherMapAPI(this._apiKey, {this.language = WeatherLanguage.Russian});

  final String _apiKey;
  final WeatherLanguage language;

  static const String _schemeUrl = 'https';
  static const String _apiBaseUrl = 'api.openweathermap.org';
  static const String _apiPath = '/data/2.5/';
  static const String _currentWeatherTag = 'weather';
  static const String _oneCallWeatherTag = 'onecall';

  Uri currentWeather(double latitude, double longitude) => _buildUri(
        tag: _currentWeatherTag,
        queryParam: () => _queryParameters(latitude, longitude),
      );

  Uri onecallWeather(double latitude, double longitude) => _buildUri(
        tag: _oneCallWeatherTag,
        queryParam: () => _queryParameters(latitude, longitude),
      );

  Uri _buildUri({
    required String tag,
    required Map<String, dynamic> Function() queryParam,
  }) {
    return Uri(
      scheme: _schemeUrl,
      host: _apiBaseUrl,
      path: '$_apiPath$tag',
      queryParameters: queryParam(),
    );
  }

  Map<String, dynamic> _queryParameters(double? lat, double? lon) => {
        'lat': lat,
        'lon': lon,
        'appid': _apiKey,
        'lang': language.code,
        'units': 'standard',
      };
}
