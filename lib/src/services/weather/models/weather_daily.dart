import '../../../utils/parse.dart';

/// Model represents daily forecast weather.
class WeatherDaily {
  const WeatherDaily(
    this._weatherData, {
    required this.date,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.tempMorning,
    required this.tempDay,
    required this.tempEvening,
    required this.tempNight,
    required this.tempMin,
    required this.tempMax,
    required this.tempFeelsLikeMorning,
    required this.tempFeelsLikeDay,
    required this.tempFeelsLikeEvening,
    required this.tempFeelsLikeNight,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDegree,
    required this.windGust,
    required this.cloudiness,
    required this.uvi,
    required this.pop,
    required this.rain,
    required this.snow,
    required this.weatherDescription,
    required this.weatherMain,
    required this.weatherIcon,
    required this.weatherConditionCode,
  });

  factory WeatherDaily.fromJson(Map<String, dynamic> jsonData) {
    final Map<String, dynamic>? temp =
        jsonData['temp'] as Map<String, dynamic>?;

    final Map<String, dynamic>? tempFeelLike =
        jsonData['feels_like'] as Map<String, dynamic>?;

    final Map<String, dynamic>? weather =
        jsonData['weather']?[0] as Map<String, dynamic>?;

    return WeatherDaily(
      jsonData,
      date: unpackDate(jsonData, 'dt'),
      sunrise: unpackDate(jsonData, 'sunrise'),
      sunset: unpackDate(jsonData, 'sunset'),
      moonrise: unpackDate(jsonData, 'moonrise'),
      moonset: unpackDate(jsonData, 'moonset'),
      moonPhase: unpackDouble(jsonData, 'moon_phase'),
      tempMorning: unpackDouble(temp, 'morn'),
      tempDay: unpackDouble(temp, 'day'),
      tempEvening: unpackDouble(temp, 'eve'),
      tempNight: unpackDouble(temp, 'night'),
      tempMin: unpackDouble(temp, 'min'),
      tempMax: unpackDouble(temp, 'max'),
      tempFeelsLikeMorning: unpackDouble(tempFeelLike, 'morn'),
      tempFeelsLikeDay: unpackDouble(tempFeelLike, 'day'),
      tempFeelsLikeEvening: unpackDouble(tempFeelLike, 'eve'),
      tempFeelsLikeNight: unpackDouble(tempFeelLike, 'night'),
      pressure: unpackDouble(jsonData, 'pressure'),
      humidity: unpackDouble(jsonData, 'humidity'),
      dewPoint: unpackDouble(jsonData, 'dew_point'),
      windSpeed: unpackDouble(jsonData, 'wind_speed'),
      windDegree: unpackDouble(jsonData, 'wind_deg'),
      windGust: unpackDouble(jsonData, 'wind_gust'),
      cloudiness: unpackDouble(jsonData, 'clouds'),
      uvi: unpackDouble(jsonData, 'uvi'),
      pop: unpackDouble(jsonData, 'pop'),
      rain: unpackDouble(jsonData, 'rain'),
      snow: unpackDouble(jsonData, 'snow'),
      weatherDescription: unpackString(weather, 'description'),
      weatherMain: unpackString(weather, 'main'),
      weatherIcon: unpackString(weather, 'icon'),
      weatherConditionCode: unpackInt(weather, 'id'),
    );
  }

  /// Time of the forecasted data.
  final DateTime? date;

  /// Sunrise time.
  final DateTime? sunrise;

  /// Sunset time.
  final DateTime? sunset;

  /// The time of when the moon rises for this day.
  final DateTime? moonrise;

  /// The time of when the moon sets for this day.
  final DateTime? moonset;

  /// Moon phase.
  ///
  /// 0 and 1 are 'new moon', 0.25 is 'first quarter moon',
  /// 0.5 is 'full moon' and 0.75 is 'last quarter moon'. The periods in
  /// between are called 'waxing crescent', 'waxing gibous', 'waning gibous',
  /// and 'waning crescent', respectively.
  final double? moonPhase;

  /// Morning temperature.
  final double? tempMorning;

  /// Day temperature.
  final double? tempDay;

  /// Evening temperature.
  final double? tempEvening;

  /// Night temperature.
  final double? tempNight;

  /// Min daily temperature.
  final double? tempMin;

  /// Max daily temperature.
  final double? tempMax;

  /// This accounts for the human perception of weather.
  /// Morning temperature.
  final double? tempFeelsLikeMorning;

  /// This accounts for the human perception of weather.
  /// Day temperature.
  final double? tempFeelsLikeDay;

  /// This accounts for the human perception of weather.
  /// Evening temperature.
  final double? tempFeelsLikeEvening;

  /// This accounts for the human perception of weather.
  /// Night temperature.
  final double? tempFeelsLikeNight;

  /// Atmospheric pressure, hPa
  final double? pressure;

  /// Humidity, %
  final double? humidity;

  /// Atmospheric temperature (varying according to pressure and humidity)
  /// below which water droplets begin to condense and dew can form.
  final double? dewPoint;

  /// Wind speed, meter/sec
  final double? windSpeed;

  /// Wind direction, degrees (meteorological)
  final double? windDegree;

  /// Wind gust, meter/sec
  final double? windGust;

  /// Cloudiness, %
  final double? cloudiness;

  /// The maximum value of UV index for the day.
  final double? uvi;

  /// Probability of precipitation.
  final double? pop;

  /// Precipitation volume, mm
  final double? rain;

  ///  Snow volume, mm
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
  String toString() {
    return '${super.toString()}(date: $date, weatherMain: $weatherMain, tempDay: $tempDay)\n';
  }

  /// The original JSON data from the API
  Map<String, dynamic> toJson() => _weatherData;
}
