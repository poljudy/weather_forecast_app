import '../../../utils/parse.dart';

/// The model is current weather data API response for [WeatherOneCall].
class WeatherCurrent {
  const WeatherCurrent(
    this._weatherData, {
    required this.date,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.tempFeelsLike,
    required this.visibility,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDegree,
    required this.windGust,
    required this.cloudiness,
    required this.uvi,
    required this.weatherDescription,
    required this.weatherMain,
    required this.weatherIcon,
    required this.weatherConditionCode,
  });

  /// Creating [WeatherCurrent] instance from json.
  factory WeatherCurrent.fromJson(Map<String, dynamic> jsonData) {
    final Map<String, dynamic>? weatherData =
        unpackList(jsonData, 'weather')?[0] as Map<String, dynamic>?;

    return WeatherCurrent(
      jsonData,
      date: unpackDate(jsonData, 'dt'),
      sunrise: unpackDate(jsonData, 'sunrise'),
      sunset: unpackDate(jsonData, 'sunset'),
      temp: unpackDouble(jsonData, 'temp'),
      tempFeelsLike: unpackDouble(jsonData, 'feels_like'),
      pressure: unpackDouble(jsonData, 'pressure'),
      humidity: unpackDouble(jsonData, 'humidity'),
      dewPoint: unpackDouble(jsonData, 'dew_point'),
      cloudiness: unpackDouble(jsonData, 'clouds'),
      uvi: unpackDouble(jsonData, 'uvi'),
      visibility: unpackDouble(jsonData, 'visibility'),
      windSpeed: unpackDouble(jsonData, 'wind_speed'),
      windDegree: unpackDouble(jsonData, 'wind_deg'),
      windGust: unpackDouble(jsonData, 'wind_gust'),
      weatherDescription: unpackString(weatherData, 'description'),
      weatherMain: unpackString(weatherData, 'main'),
      weatherIcon: unpackString(weatherData, 'icon'),
      weatherConditionCode: unpackInt(weatherData, 'id'),
    );
  }

  /// Time of the forecasted data.
  final DateTime? date;

  /// Sunrise time.
  final DateTime? sunrise;

  /// Sunset time.
  final DateTime? sunset;

  /// Temperature now.
  final double? temp;

  /// This Temperature parameter accounts for the human perception of weather.
  final double? tempFeelsLike;

  /// Atmospheric pressure, hPa
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

  /// Wind direction, degrees (meteorological).
  final double? windDegree;

  /// Wind gust, meter/sec
  final double? windGust;

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
      '$WeatherCurrent(date: $date, weatherMain: $weatherMain, temp: $temp)';

  /// The original JSON data from the API.
  Map<String, dynamic> toJson() => _weatherData;
}

/// Safely conversion of json to accepted view
/// after request [WeatherService.currentWeatherByLocation].
Map<String, dynamic> parseCurrent(Map<String, dynamic> jsonCurrent) {
  return {
    'timezone_offset': jsonCurrent['timezone'],
    'dt': jsonCurrent['dt'],
    'sunrise': unpackMap(jsonCurrent, 'sys')?['sunrise'],
    'sunset': unpackMap(jsonCurrent, 'sys')?['sunset'],
    'temp': unpackMap(jsonCurrent, 'main')?['temp'],
    'feels_like': unpackMap(jsonCurrent, 'main')?['feels_like'],
    'pressure': unpackMap(jsonCurrent, 'main')?['pressure'],
    'humidity': unpackMap(jsonCurrent, 'main')?['humidity'],
    'clouds': unpackMap(jsonCurrent, 'clouds')?['all'],
    'visibility': jsonCurrent['visibility'],
    'wind_speed': unpackMap(jsonCurrent, 'wind')?['speed'],
    'wind_deg': unpackMap(jsonCurrent, 'wind')?['deg'],
    'wind_gust': unpackMap(jsonCurrent, 'wind')?['gust'],
    'weather': jsonCurrent['weather'],
  };
}
