import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:weather_pack/src/services/geocoding/place_geocode_model.dart';
import 'package:weather_pack/src/utils/languages.dart';

void main() {
  group('$PlaceGeocode', () {
    const List<String> directGeocodingPaths = [
      'test/source/direct_geocoding_16.02.22.json',
      // add here when will need
    ];

    test('$PlaceGeocode.fromJson', () async {
      for (final path in directGeocodingPaths) {
        final String response = await File(path).readAsString();

        final data = await json.decode(response);

        final place = PlaceGeocode.fromJson(data as Map<String, dynamic>);

        expect(place.runtimeType, PlaceGeocode);
        expect(place.longitude, isNotNull);
        expect(place.latitude, isNotNull);
        expect(place.name, isNotNull);
        expect(place.state, isNotNull);
        expect(place.localNames, isNotNull);
        expect(place.localNames![WeatherLanguage.english], isNotNull);
        expect(place.toJson(), isNotEmpty);
      }
    });
  });
}
