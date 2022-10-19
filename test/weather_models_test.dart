import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:weather_pack/src/services/weather/all_weather_model.dart';

// ignore_for_file: avoid_print

void main() {
  group('$WeatherCurrent', () {
    const List<String> currentPaths = [
      'test/source/current_16.02.22.json',
      // add here when will need
    ];

    test('$WeatherCurrent.fromJson', () async {
      for (final path in currentPaths) {
        final String response = await File(path).readAsString();

        final data = await json.decode(response);

        final current =
            WeatherCurrent.fromJson(parseCurrent(data as Map<String, dynamic>));

        expect(current.runtimeType, WeatherCurrent);
        expect(current.temp, isNotNull);
        expect(current.date, isNotNull);
        expect(current.weatherMain, isNotNull);
        expect(current.toJson(), isNotEmpty);
      }
    });
  });

  group('$WeatherOneCall', () {
    const List<String> oneCallPaths = [
      'test/source/one_call_16.02.22.json',
      'test/source/one_call_17.10.22.json',
      // add here when will need
    ];

    test('$WeatherOneCall.fromJson', () async {
      for (final path in oneCallPaths) {
        final String response = await File(path).readAsString();

        final data = await json.decode(response);

        final oneCall = WeatherOneCall.fromJson(data as Map<String, dynamic>);

        expect(oneCall.runtimeType, WeatherOneCall);
        expect(oneCall.longitude, isNotNull);
        expect(oneCall.latitude, isNotNull);
        expect(oneCall.current, isNotNull);
        expect(oneCall.minutely, isNotNull);
        expect(oneCall.hourly, isNotNull);
        expect(oneCall.daily, isNotNull);
        expect(oneCall.alerts, isNotNull);
      }
    });
  });
}
