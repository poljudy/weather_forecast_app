import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_weather_api/src/models/weather_current.dart';

import 'models/weather_one_call.dart';
import 'utils/exceptions.dart';
import 'utils/languages.dart';

/// Plugin for fetching weather data in JSON.
class WeatherDomain {
  WeatherDomain(this._apiKey, {this.language = WeatherLanguage.Russian}) {
    // wg = WeatherGeocoding(_apiKey);
  }

  // static const String forecastWeather = 'forecast';
  static const String _currentWeather = 'weather';
  static const String _oneCallWeather = 'onecall';
  static const int _statusOk = 200;
  static const int _statusOkTestApi = 400;
  static const int _statusApiError = 401;

  final String _apiKey;
  final WeatherLanguage language;
  final http.Client _httpClient = http.Client();

  static Future<bool> isCorrectApi(String yourApi) async {
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?appid=$yourApi';

    final http.Response response = await http.Client().get(Uri.parse(url));

    if (response.statusCode == _statusOk ||
        response.statusCode == _statusOkTestApi) {
      return true;
    } else if (response.statusCode == _statusApiError) {
      return false;
    }
    return false;
  }

  /// Fetch [WeatherOneCall] based on geographical coordinates.
  ///
  /// Result is JSON.
  /// For API documentation, see: https://openweathermap.org/api/one-call-api
  Future<WeatherOneCall> oneCallWeatherByLocation(
      {required double latitude, required double longitude}) async {
    final Map<String, dynamic> jsonResponse =
        await _sendRequest(_oneCallWeather, lat: latitude, lon: longitude);

    return WeatherOneCall.fromJson(jsonResponse);
  }

  /// Fetch [WeatherCurrent] based on geographical coordinates.
  ///
  /// Result is JSON.
  /// For API documentation, see: https://openweathermap.org/current
  Future<WeatherCurrent> currentWeatherByLocation(
      {required double latitude, required double longitude}) async {
    final Map<String, dynamic> jsonResponse =
        await _sendRequest(_currentWeather, lat: latitude, lon: longitude);

    return WeatherCurrent.fromJson(parseCurrent(jsonResponse));
  }

  /// Make a service request.
  Future<Map<String, dynamic>> _sendRequest(
    String tag, {
    double? lat,
    double? lon,
  }) async {
    final String url = _buildUrl(tag, lat, lon);

    final http.Response response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == _statusOk) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw OpenWeatherAPIException(
          'The API threw an exception: ${response.body}, ${response.statusCode}');
    }
  }

  /// Build url assemble according to the parameters.
  String _buildUrl(String tag, double? lat, double? lon) {
    String url = 'https://api.openweathermap.org/data/2.5/$tag?';

    url += 'lat=$lat&lon=$lon&';
    url += 'appid=$_apiKey&';
    url += 'lang=${language.code}';
    return url;
  }
}
