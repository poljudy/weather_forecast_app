// ignore_for_file: avoid_classes_with_only_static_members

/// The class provides a helper for getting the image path of a given package.
class ImagePathWeather {
  ImagePathWeather._();

  static const String _root = 'assets/weather_icons';

  static const packageName = 'weather_pack';

  /// Get path to weather icon.
  ///
  /// param:
  /// * weatherIcon - ex. '11d' or '01d' and etc.
  static String getPathWeatherIcon(String weatherIcon) =>
      '$_root/$weatherIcon.png';
}
