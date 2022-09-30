import '../../api/api.dart';
import '../http_repository.dart';
import 'place_geocode_model.dart';

/// The class provides access to the geocoding service of cities.
///
/// Supports both the direct and reverse methods:
/// * Direct geocoding converts the specified name of a location or zip/post code
/// into the exact geographical coordinates;
/// * Reverse geocoding converts the geographical coordinates into
/// the names of the nearby locations;
///
/// Learn more [geocoding-api](https://openweathermap.org/api/geocoding-api)
class GeocodingService {
  GeocodingService({
    required this.owmApi,
  });

  final OWMApi owmApi;

  final HttpRepository httpRepo = HttpRepository();

  /// Get locations based on the approximate name of the location.
  ///
  /// params:
  /// * cityName -> city name on local language.
  /// * limit -> Number of the locations in the API response (no more than 5).
  Future<List<PlaceGeocode>> getLocationByCityName(String cityName,
          {int limit = 5}) async =>
      httpRepo.getData(
        uri: owmApi.uriLocationByCityName(cityName),
        builder: (dynamic data) => _castData(data),
      );

  /// Get locations by coordinates.
  ///
  /// params:
  /// * latitude -> Latitude of the weather observation.
  /// * longitude -> Longitude of the weather observation.
  /// * limit -> Number of the locations in the API response (no more than 5).
  Future<List<PlaceGeocode>> getLocationByCoordinates({
    required double latitude,
    required double longitude,
    int limit = 5,
  }) async {
    return httpRepo.getData(
      uri: owmApi.uriLocationByCoordinates(latitude, longitude, limit: limit),
      builder: (dynamic data) => _castData(data),
    );
  }

  // todo: For manually parsing a list of json locations (aka "I handle it myself").

  List<PlaceGeocode> _castData(dynamic data) => (data as List<dynamic>)
      .map(
          (dynamic json) => PlaceGeocode.fromJson(json as Map<String, dynamic>))
      .toList();
}
