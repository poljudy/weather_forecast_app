import '../../../utils/parse.dart';

/// Model represents hourly forecast weather data.
class WeatherHourly {
  WeatherHourly(
    this._weatherData, {
    required this.date,
    required this.temp,
    required this.tempFeelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.cloudiness,
    required this.visibility,
    required this.windSpeed,
    required this.windDegree,
    required this.windGust,
    required this.pop,
    required this.rain,
    required this.snow,
    required this.weatherDescription,
    required this.weatherMain,
    required this.weatherIcon,
    required this.weatherConditionCode,
  });

  factory WeatherHourly.fromJson(Map<String, dynamic> jsonData) {
    final Map<String, dynamic>? weather =
        jsonData['weather']?[0] as Map<String, dynamic>?; // it's ok!

    final Map<String, dynamic>? rain =
        jsonData['rain'] as Map<String, dynamic>?;

    final Map<String, dynamic>? snow =
        jsonData['snow'] as Map<String, dynamic>?;

    return WeatherHourly(
      jsonData,
      date: unpackDate(jsonData, 'dt'),
      temp: unpackDouble(jsonData, 'temp'),
      tempFeelsLike: unpackDouble(jsonData, 'feels_like'),
      pressure: unpackDouble(jsonData, 'pressure'),
      humidity: unpackDouble(jsonData, 'humidity'),
      dewPoint: unpackDouble(jsonData, 'dew_point'),
      windSpeed: unpackDouble(jsonData, 'wind_speed'),
      windDegree: unpackDouble(jsonData, 'wind_deg'),
      windGust: unpackDouble(jsonData, 'wind_gust'),
      cloudiness: unpackDouble(jsonData, 'clouds'),
      visibility: unpackDouble(jsonData, 'visibility'),
      uvi: unpackDouble(jsonData, 'uvi'),
      pop: unpackDouble(jsonData, 'pop'),
      rain: unpackDouble(rain, '1h'),
      snow: unpackDouble(snow, '1h'),
      weatherDescription: unpackString(weather, 'description'),
      weatherMain: unpackString(weather, 'main'),
      weatherIcon: unpackString(weather, 'icon'),
      weatherConditionCode: unpackInt(weather, 'id'),
    );
  }

  /// Time of the forecasted data.
  final DateTime? date;

  /// Temperature now.
  final double? temp;

  /// Temperature now. This accounts for the human perception of weather.
  final double? tempFeelsLike;

  /// Atmospheric pressure on the sea level, hPa (hectopascal) - 10^2
  final double? pressure;

  /// Humidity, %
  final double? humidity;

  /// Atmospheric temperature (varying according to pressure and humidity)
  /// below which water droplets begin to condense and dew can form.
  final double? dewPoint;

  /// The maximum value of UV index for the day.
  final double? uvi;

  /// Cloudiness, %
  final double? cloudiness;

  /// Average visibility, metres
  final double? visibility;

  /// Wind speed, meter/sec
  final double? windSpeed;

  /// Wind direction, degrees (meteorological)
  final double? windDegree;

  /// Wind gust, meter/sec
  final double? windGust;

  /// Probability of precipitation, %, decimal
  final double? pop;

  /// Rain volume for last hour, mm
  final double? rain;

  /// Snow volume for last hour, mm
  final double? snow;

  /// A long description of the weather.
  final String? weatherDescription;

  /// A brief description of the weather.
  final String? weatherMain;

  /// Icon depicting current weather.
  final String? weatherIcon;

  /// Weather condition codes.
  final int? weatherConditionCode;

  /// The original JSON data from the API.
  final Map<String, dynamic> _weatherData;

  @override
  String toString() =>
      '${super.toString()}(date: $date, weatherMain: $weatherMain, tempDay: $temp)\n';

  /// The original JSON data from the API.
  Map<String, dynamic> toJson() => _weatherData;
}
