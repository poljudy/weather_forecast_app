import '../../../utils/parse.dart';

/// Model represents minute forecast weather.
class WeatherMinutely {
  WeatherMinutely(
    this._weatherData, {
    required this.date,
    required this.precipitation,
  });

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
  String toString() {
    return '${super.toString()}(date: $date, precipitation: $precipitation)\n';
  }

  /// The original JSON data from the API.
  Map<String, dynamic> toJson() => _weatherData;
}
