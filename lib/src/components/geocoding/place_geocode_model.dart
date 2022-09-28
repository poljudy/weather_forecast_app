import '../../utils/languages.dart';
import '../../utils/parse.dart';

/// The model represents the location.
///
/// Place returned when searching for locations by geocoding service.
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

  factory PlaceGeocode.fromJson(Map<String, dynamic> jsonData) {
    final Map<WeatherLanguage, String> localNames = {};
    final Map? localNamesData = jsonData['local_names'] as Map?;

    if (localNamesData != null) {
      // todo написать всю эту кашу понятней.
      for (final entry in localNamesData.entries) {
        final String key = entry.key as String;
        final String value = entry.value as String;

        if (entry.value != null) {
          if (languageCodeReverse.containsKey(key)) {
            localNames[languageCodeReverse[key]!] = value;
          }
        }
      }
    }

    return PlaceGeocode(
      jsonData,
      name: unpackString(jsonData, 'name'),
      latitude: unpackDouble(jsonData, 'lat'),
      longitude: unpackDouble(jsonData, 'lon'),
      localNames: localNames.isNotEmpty ? localNames : null,
      countryCode: unpackString(jsonData, 'country'),
      state: unpackString(jsonData, 'state'),
    );
  }

  /// Name of the found location.
  final String? name;

  /// Name of the found location in different languages.
  ///
  /// The list of names can be different for different locations.
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

  /// Two [PlaceGeocode]s are considered equal if their longitude and latitude are the same.
  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlaceGeocode &&
            longitude == other.longitude &&
            latitude == other.latitude);
  }

  /// Same hashCode if longitude and latitude are the same.
  @override
  int get hashCode => Object.hash(
        runtimeType,
        latitude,
        longitude,
      );

  @override
  String toString() =>
      '${super.toString()}(name: $name, latitude: $latitude, longitude: $longitude)';
}
