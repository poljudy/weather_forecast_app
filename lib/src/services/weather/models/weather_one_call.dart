import '../../../utils/parse.dart';
import 'weather_alerts.dart';
import 'weather_current.dart';
import 'weather_daily.dart';
import 'weather_hourly.dart';
import 'weather_minutely.dart';

/// Model represents weather by One Call API request.
///
/// The One Call API provides the following weather data:
/// * Current weather - [WeatherCurrent]
/// * Minute forecast for 1 hour - [WeatherMinutely]
/// * Hourly forecast for 48 hours - [WeatherHourly]
/// * Daily forecast for 7 days - [WeatherDaily]
/// * National weather alerts - [WeatherAlert]
///
/// See more [one-call-api](https://openweathermap.org/api/one-call-api)
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

  /// Check [List] to empty or null.
  static bool _isData<T extends List?>(T data) => data?.isNotEmpty ?? false;

  /// Creating [WeatherOneCall] instance from json.
  factory WeatherOneCall.fromJson(Map<String, dynamic> jsonData) {
    final currentData = unpackMap(jsonData, 'current');
    final minutelyData = unpackList(jsonData, 'minutely');
    final hourlyData = unpackList(jsonData, 'hourly');
    final dailyData = unpackList(jsonData, 'daily');
    final alertsData = unpackList(jsonData, 'alerts');

    return WeatherOneCall(
      jsonData,
      latitude: unpackDouble(jsonData, 'lat'),
      longitude: unpackDouble(jsonData, 'lon'),
      timezone: unpackString(jsonData, 'timezone'),
      timezoneOffset: unpackDate(jsonData, 'timezone_offset'),
      current: currentData?.isNotEmpty ?? false
          ? WeatherCurrent.fromJson(currentData! as Map<String, dynamic>)
          : null,
      minutely: _isData(minutelyData)
          ? minutelyData!
              .map((w) => WeatherMinutely.fromJson(w as Map<String, dynamic>))
              .toList()
          : null,
      hourly: _isData(hourlyData)
          ? hourlyData!
              .map((w) => WeatherHourly.fromJson(w as Map<String, dynamic>))
              .toList()
          : null,
      daily: _isData(dailyData)
          ? dailyData!
              .map((w) => WeatherDaily.fromJson(w as Map<String, dynamic>))
              .toList()
          : null,
      alerts: _isData(alertsData)
          ? alertsData!
              .map((w) => WeatherAlert.fromJson(w as Map<String, dynamic>))
              .toList()
          : null,
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
      '$WeatherOneCall(lat: $latitude, lon: $longitude, temp: ${current?.temp})';

  /// The original JSON data from the API
  Map<String, dynamic> toJson() => _weatherData;
}
