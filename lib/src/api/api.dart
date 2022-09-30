import '../utils/languages.dart';

/// Uri builder class for the OpenWeatherMap(OWM) API.
class OWMApi {
  OWMApi({
    required this.apiKey,
    this.language = WeatherLanguage.russian,
  });

  final String apiKey;
  final WeatherLanguage language;

  static const String _schemeUrl = 'https';
  static const String _apiBaseUrl = 'api.openweathermap.org';

  /// Create uri for testing apikey in OWM service.
  static Uri uriTestApikey(String apikey) => Uri(
        scheme: _schemeUrl,
        host: _apiBaseUrl,
        path: '$_apiPathWeather$_currentWeatherTag',
        queryParameters: {'appid': apikey},
      );

  // ===========================================================================
  // Weather

  static const String _apiPathWeather = '/data/2.5/';
  static const String _currentWeatherTag = 'weather';
  static const String _oneCallWeatherTag = 'onecall';

  Uri uriCurrentWeather(double latitude, double longitude) => _buildUri(
        path: _apiPathWeather,
        tag: _currentWeatherTag,
        queryParams: () => _queryParametersWeather(latitude, longitude),
      );

  Uri uriOnecallWeather(double latitude, double longitude) => _buildUri(
        path: _apiPathWeather,
        tag: _oneCallWeatherTag,
        queryParams: () => _queryParametersWeather(latitude, longitude),
      );

  Map<String, dynamic> _queryParametersWeather(double? lat, double? lon) => {
        'lat': lat,
        'lon': lon,
        'appid': apiKey,
        'lang': language.code,
        'units': 'standard',
      };

  // ===========================================================================
  // Geocoding

  static const String _apiPathGeocoding = '/geo/1.0/';
  static const String _directGeocodingTag = 'direct';
  static const String _reverseGeocodingTag = 'reverse';

  Uri uriLocationByCityName(String cityName, {int limit = 5}) => _buildUri(
        path: _apiPathGeocoding,
        tag: _directGeocodingTag,
        queryParams: () => _queryParamsDirectGeocoding(cityName, limit),
      );

  Map<String, dynamic> _queryParamsDirectGeocoding(
          String cityName, int limit) =>
      {
        'q': cityName,
        'limit': limit,
        'appid': apiKey,
      };

  Uri uriLocationByCoordinates(double lat, double lon, {int limit = 5}) =>
      _buildUri(
        path: _apiPathGeocoding,
        tag: _reverseGeocodingTag,
        queryParams: () => _queryParamsReverseGeocoding(lat, lon, limit),
      );

  /// -> param:
  /// * tag: direct or reverse
  /// * cityName: city name on local language
  /// * limit: Number of the locations in the API response (no more than 5)
  /// * lat: latitude
  /// * lon: longitude
  Map<String, dynamic> _queryParamsReverseGeocoding(
          double lat, double lon, int limit) =>
      {
        'lat': lat,
        'lon': lon,
        'limit': limit,
        'appid': apiKey,
      };

  //============================================================================
  // build

  Uri _buildUri({
    required String path,
    required String tag,
    required Map<String, dynamic> Function() queryParams,
  }) {
    return Uri(
      scheme: _schemeUrl,
      host: _apiBaseUrl,
      path: '$path$tag',
      queryParameters: queryParams(),
    );
  }
}
