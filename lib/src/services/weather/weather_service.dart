import '../../api/api.dart';
import '../http_repository.dart';
import 'all_weather_model.dart';

/// Plugin for fetching weather data in JSON.
class WeatherService {
  WeatherService({
    required this.owmApi,
  });

  final OWMApi owmApi;

  final HttpRepository httpRepo = HttpRepository();

  /// Fetch [WeatherOneCall] based on geographical coordinates.
  ///
  /// Result is JSON.
  /// For API documentation, see: [WeatherOnecall](https://openweathermap.org/api/one-call-api)
  Future<WeatherOneCall> oneCallWeatherByLocation(
          {required double latitude, required double longitude}) async =>
      httpRepo.getData(
          uri: owmApi.uriOnecallWeather(latitude, longitude),
          builder: (dynamic data) {
            return WeatherOneCall.fromJson(
                parseCurrent(data as Map<String, dynamic>));
          });

  /// Fetch [WeatherCurrent] based on geographical coordinates.
  ///
  /// Result is JSON.
  /// For API documentation, see: [WeatherCurrent](https://openweathermap.org/current)
  Future<WeatherCurrent> currentWeatherByLocation(
          {required double latitude, required double longitude}) async =>
      httpRepo.getData(
          uri: owmApi.uriCurrentWeather(latitude, longitude),
          builder: (dynamic data) {
            return WeatherCurrent.fromJson(
                parseCurrent(data as Map<String, dynamic>));
          });
}
