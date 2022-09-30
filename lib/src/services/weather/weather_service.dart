import 'package:open_weather_api/src/models/weather_current.dart';

import '../../models/weather_one_call.dart';
import '../../api/weather_api.dart';
import '../i_service.dart';

/// Plugin for fetching weather data in JSON.
class WeatherService with Client {
  WeatherService(this._owmApi);

  final OpenWeatherMapAPI _owmApi;

  /// Fetch [WeatherOneCall] based on geographical coordinates.
  ///
  /// Result is JSON.
  /// For API documentation, see: [WeatherOnecall](https://openweathermap.org/api/one-call-api)
  Future<WeatherOneCall> oneCallWeatherByLocation(
          {required double latitude, required double longitude}) async =>
      getData(
          uri: _owmApi.onecallWeather(latitude, longitude),
          builder: (data) {
            return WeatherOneCall.fromJson(
                parseCurrent(data as Map<String, dynamic>));
          });

  /// Fetch [WeatherCurrent] based on geographical coordinates.
  ///
  /// Result is JSON.
  /// For API documentation, see: [WeatherCurrent](https://openweathermap.org/current)
  Future<WeatherCurrent> currentWeatherByLocation(
          {required double latitude, required double longitude}) async =>
      getData(
          uri: _owmApi.currentWeather(latitude, longitude),
          builder: (data) {
            return WeatherCurrent.fromJson(
                parseCurrent(data as Map<String, dynamic>));
          });
}
