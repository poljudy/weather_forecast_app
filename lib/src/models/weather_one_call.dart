import '../utils/parse.dart';
import 'weather_alerts.dart';
import 'weather_current.dart';
import 'weather_daily.dart';
import 'weather_hourly.dart';
import 'weather_minutely.dart';

/// Model represents weather by One Call API request.
///
/// The One Call API provides the following weather data:
/// * Current weather
/// * Minute forecast for 1 hour
/// * Hourly forecast for 48 hours
/// * Daily forecast for 7 days
/// * National weather alerts
class WeatherOneCall {
  const WeatherOneCall(
    this._weatherData, {
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.minutely,
    required this.hourly,
    required this.daily,
    required this.alerts,
  });

  factory WeatherOneCall.fromJson(Map<String, dynamic> jsonData) {
    return WeatherOneCall(
      jsonData,
      latitude: unpackDouble(jsonData, 'lat'),
      longitude: unpackDouble(jsonData, 'lon'),
      timezone: unpackString(jsonData, 'timezone'),
      timezoneOffset: unpackDate(jsonData, 'timezone_offset'),
      current:
          WeatherCurrent.fromJson(jsonData['current'] as Map<String, dynamic>),
      minutely: (jsonData['minutely'] as List?)
          ?.map((w) => WeatherMinutely.fromJson(w as Map<String, dynamic>))
          .toList(),
      hourly: (jsonData['hourly'] as List?)
          ?.map((w) => WeatherHourly.fromJson(w as Map<String, dynamic>))
          .toList(),
      daily: (jsonData['daily'] as List?)
          ?.map((w) => WeatherDaily.fromJson(w as Map<String, dynamic>))
          .toList(),
      alerts: (jsonData['alerts'] as List?)
          ?.map((w) => WeatherAlert.fromJson(w as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Latitude of the weather observation.
  final double? latitude;

  /// Longitude of the weather observation.
  final double? longitude;

  /// Timezone name for the requested location.
  final String? timezone;

  /// Shift in seconds from UTC.
  final DateTime? timezoneOffset;

  /// Current weather.
  final WeatherCurrent? current;

  /// Minute forecast weather.
  final List<WeatherMinutely>? minutely;

  /// Hourly forecast weather.
  final List<WeatherHourly>? hourly;

  /// Daily forecast weather.
  final List<WeatherDaily>? daily;

  /// National weather alerts data from major national weather warning systems.
  final List<WeatherAlert>? alerts;

  /// The original JSON data from the API.
  final Map<String, dynamic> _weatherData;

  @override
  String toString() =>
      '${super.toString()} lat: $latitude, lon: $longitude, temp: ${current?.temp}';

  /// The original JSON data from the API
  Map<String, dynamic> toJson() => _weatherData;
}
