import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/exceptions.dart';
import 'place_geocode_model.dart';

/// The class provides access to the geocoding service of cities.
///
/// Supports both the direct and reverse methods:
/// * Direct geocoding converts the specified name of a location or zip/post code
/// into the exact geographical coordinates;
/// * Reverse geocoding converts the geographical coordinates into
/// the names of the nearby locations;
class WeatherGeocoding {
  WeatherGeocoding(this._apiKey);

  final http.Client _httpClient = http.Client();

  /// Your unique API key.
  final String _apiKey;

  static const String directGeocoding = 'direct';
  static const String reverseGeocoding = 'reverse';

  static const int statusOk = 200;

  /// Get locations based on the approximate name of the location.
  ///
  /// params:
  /// * cityName -> city name on local language.
  /// * limit -> Number of the locations in the API response (no more than 5).
  Future<List<PlaceGeocode>> getLocationByCityName(String cityName,
      {int limit = 5}) async {
    final List<dynamic> jsonGeocodingDirect = await _sendRequest(
      directGeocoding,
      cityName: cityName,
      limit: limit,
    );

    if (jsonGeocodingDirect.isEmpty) return [];

    final List<PlaceGeocode> list = jsonGeocodingDirect
        .map(
          (dynamic json) => PlaceGeocode.fromJson(json as Map<String, dynamic>),
        )
        .toList();

    return list;
  }

  /// For manually parsing a list of json locations (aka "I handle it myself").
  ///
  /// Useful to use when the variable in the weather server's response has changed,
  /// while the package author is busy relaxing :)
  ///
  /// Get locations based on the approximate name of the location.
  ///
  /// params:
  /// * cityName -> city name on local language.
  /// * limit -> Number of the locations in the API response (no more than 5).
  Future<List<dynamic>> handGetLocationByCityName(String cityName,
      {int limit = 5}) async {
    return _sendRequest(
      directGeocoding,
      cityName: cityName,
      limit: limit,
    );
  }

  /// Get locations by coordinates.
  ///
  /// params:
  /// * latitude -> Latitude of the weather observation.
  /// * longitude -> Longitude of the weather observation.
  /// * limit -> Number of the locations in the API response (no more than 5).
  Future<List<PlaceGeocode>> getLocationByCoordinates({
    required double latitude,
    required double longitude,
    int limit = 5,
  }) async {
    final List<dynamic> jsonGeocodingDirect = await _sendRequest(
      reverseGeocoding,
      lat: latitude,
      lon: longitude,
      limit: limit,
    );

    if (jsonGeocodingDirect.isEmpty) return [];

    final List<PlaceGeocode> list = jsonGeocodingDirect
        .map(
          (dynamic json) => PlaceGeocode.fromJson(json as Map<String, dynamic>),
        )
        .toList();

    return list;
  }

  /// For manually parsing a list of json locations (aka "I handle it myself").
  ///
  /// Get locations by coordinates.
  ///
  /// params:
  /// * latitude -> Latitude of the weather observation.
  /// * longitude -> Longitude of the weather observation.
  /// * limit -> Number of the locations in the API response (no more than 5).
  Future<List<dynamic>> handGetLocationByCoordinates({
    required double latitude,
    required double longitude,
    int limit = 5,
  }) async {
    return _sendRequest(
      reverseGeocoding,
      lat: latitude,
      lon: longitude,
      limit: limit,
    );
  }

  /// We send a request and get a list of data.
  Future<List<dynamic>> _sendRequest(
    String tag, {
    double? lat,
    double? lon,
    String? cityName,
    required int limit,
  }) async {
    final String url = _buildUrl(tag, cityName, limit, lat, lon);

    final http.Response response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == statusOk) {
      final List<dynamic> jsonBody =
          json.decode(response.body) as List<dynamic>;
      return jsonBody;
    } else {
      throw OpenWeatherAPIException(
        'The API threw an exception: ${response.body}',
      );
    }
  }

  /// -> param:
  /// * tag: direct or reverse
  /// * cityName: city name on local language
  /// * limit: Number of the locations in the API response (no more than 5)
  /// * lat: latitude
  /// * lon: longitude
  String _buildUrl(
      String tag, String? cityName, int limit, double? lat, double? lon) {
    String url = 'http://api.openweathermap.org/geo/1.0/$tag?';

    if (cityName != null) {
      url += 'q=$cityName&';
    } else {
      url += 'lat=$lat&lon=$lon&';
    }

    url += 'limit=$limit&';

    return url += 'appid=$_apiKey';
  }
}
