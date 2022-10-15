import '../../../utils/parse.dart';

/// Model represents minute forecast weather for [WeatherOneCall].
class WeatherMinutely {
  WeatherMinutely(
    this._weatherData, {
    required this.date,
    required this.precipitation,
  });

  /// Creating [WeatherMinutely] instance from json.
  factory WeatherMinutely.fromJson(Map<String, dynamic> jsonData) {
    return WeatherMinutely(
      jsonData,
      date: unpackDate(jsonData, 'dt'),
      precipitation: unpackDouble(jsonData, 'precipitation'),
    );
  }

  /// Time of the forecasted data.
  final DateTime? date;

  /// Precipitation volume, mm
  final double? precipitation;

  /// The original JSON data from the API.
  final Map<String, dynamic> _weatherData;

  @override
  String toString() =>
      '$WeatherMinutely(date: $date, precipitation: $precipitation)';

  /// The original JSON data from the API.
  Map<String, dynamic> toJson() => _weatherData;
}
