import '../utils/languages.dart';

/// Uri builder class for the OpenWeatherMap(OWM) API.
class OWMApi {
  OWMApi(
    this._apiKey, {
    WeatherLanguage language = WeatherLanguage.english,
  }) : _language = language;

  final String _apiKey;
  final WeatherLanguage _language;

  static const String _schemeUrl = 'https';
  static const String _apiBaseUrl = 'api.openweathermap.org';

  // ===========================================================================
  // Weather

  static const String _apiPathWeather = '/data/2.5/';
  static const String _currentWeatherEndpoint = 'weather';
  static const String _oneCallWeatherEndpoint = 'onecall';

  Uri uriCurrentWeather(double latitude, double longitude) => _buildUri(
        path: _apiPathWeather,
        endpoint: _currentWeatherEndpoint,
        queryParams: () => _queryParametersWeather(latitude, longitude),
      );

  Uri uriOnecallWeather(double latitude, double longitude) => _buildUri(
        path: _apiPathWeather,
        endpoint: _oneCallWeatherEndpoint,
        queryParams: () => _queryParametersWeather(latitude, longitude),
      );

  Map<String, dynamic> _queryParametersWeather(double? lat, double? lon) => {
        'lat': lat,
        'lon': lon,
        'appid': _apiKey,
        'lang': _language.code,
        'units': 'standard',
      };

  // ===========================================================================
  // Geocoding

  static const String _apiPathGeocoding = '/geo/1.0/';
  static const String _directGeocodingEndpoint = 'direct';
  static const String _reverseGeocodingEndpoint = 'reverse';

  Uri uriLocationByCityName(String cityName, {int limit = 5}) => _buildUri(
        path: _apiPathGeocoding,
        endpoint: _directGeocodingEndpoint,
        queryParams: () => _queryParamsDirectGeocoding(cityName, limit),
      );

  Map<String, dynamic> _queryParamsDirectGeocoding(
    String cityName,
    int limit,
  ) =>
      {
        'q': cityName,
        'limit': limit,
        'appid': _apiKey,
      };

  Uri uriLocationByCoordinates(double lat, double lon, {int limit = 5}) =>
      _buildUri(
        path: _apiPathGeocoding,
        endpoint: _reverseGeocodingEndpoint,
        queryParams: () => _queryParamsReverseGeocoding(lat, lon, limit),
      );

  /// -> param:
  /// * limit: Number of the locations in the API response (no more than 5)
  /// * lat: latitude
  /// * lon: longitude
  Map<String, dynamic> _queryParamsReverseGeocoding(
    double lat,
    double lon,
    int limit,
  ) =>
      {
        'lat': lat,
        'lon': lon,
        'limit': limit,
        'appid': _apiKey,
      };

  //============================================================================
  // testing api

  /// Create uri for testing APIkey in OWM service.
  static Uri uriTestApikey(String apikey) => Uri(
        scheme: _schemeUrl,
        host: _apiBaseUrl,
        path: '$_apiPathWeather$_currentWeatherEndpoint',
        queryParameters: {'appid': apikey},
      );

  //============================================================================
  // build

  Uri _buildUri({
    required String path,
    required String endpoint,
    required Map<String, dynamic> Function() queryParams,
  }) =>
      Uri(
        scheme: _schemeUrl,
        host: _apiBaseUrl,
        path: '$path$endpoint',
        queryParameters: queryParams().map((key, value) {
          // we must explicitly call `toString()`
          // because type `queryParameters` is /*String|Iterable<String>*/
          return MapEntry(key, value.toString());
        }),
      );
}
