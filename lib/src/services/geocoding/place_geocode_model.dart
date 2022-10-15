import '../../utils/languages.dart';
import '../../utils/parse.dart';

/// The model represents the location.
///
/// Place returned when searching for locations by geocoding service [GeocodingService].
class PlaceGeocode {
  const PlaceGeocode(
    this._weatherData, {
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.localNames,
    required this.countryCode,
    required this.state,
  });

  /// Creating [PlaceGeocode] instance from json.
  factory PlaceGeocode.fromJson(Map<String, dynamic> jsonData) {
    return PlaceGeocode(
      jsonData,
      name: unpackString(jsonData, 'name'),
      latitude: unpackDouble(jsonData, 'lat'),
      longitude: unpackDouble(jsonData, 'lon'),
      localNames: _safelyParseLocalNames(unpackMap(jsonData, 'local_names')),
      countryCode: unpackString(jsonData, 'country'),
      state: unpackString(jsonData, 'state'),
    );
  }

  /// Name of the found location.
  final String? name;

  /// Name of the found location in different languages.
  ///
  /// The list of names can be different for different locations.
  ///
  /// (!) if (localNames.isEmpty) => localNames = null
  final Map<WeatherLanguage, String>? localNames;

  /// Latitude of the weather observation.
  final double? latitude;

  /// Longitude of the weather observation.
  final double? longitude;

  /// Country code. Please use ISO 3166-alpha2 country codes.
  final String? countryCode;

  /// State of the found location.
  ///
  /// Example, state or region.
  final String? state;

  /// The original JSON data from the API.
  final Map<String, dynamic> _weatherData;

  /// The original JSON data from the API
  Map<String, dynamic> toJson() => _weatherData;

  static Map<WeatherLanguage, String>? _safelyParseLocalNames(
    Map<dynamic, dynamic>? jsonData,
  ) {
    if (jsonData == null) return null;

    final localNames = <WeatherLanguage, String>{};

    for (final entry in jsonData.entries) {
      // ex. entry = {"ru": "Москва"}
      final String key = entry.key as String; // ex. "ru"
      final String value = entry.value as String; // ex. "Москва"

      if (entry.value != null) {
        if (codeAndLangMatching.containsKey(key)) {
          localNames[codeAndLangMatching[key]!] = value;
        }
      }
    }

    if (localNames.isEmpty) return null;

    return localNames;
  }

  // todo?: нужно ли переопределять [operator ==] and [hashCode]?

  /// Two [PlaceGeocode]s are considered equal if their longitude and latitude are the same.
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType &&
          other is PlaceGeocode &&
          longitude == other.longitude &&
          latitude == other.latitude);

  /// Same hashCode if longitude and latitude are the same.
  @override
  int get hashCode => Object.hash(
        runtimeType,
        latitude,
        longitude,
      );

  @override
  String toString() =>
      '$PlaceGeocode(name: $name, latitude: $latitude, longitude: $longitude)';
}
