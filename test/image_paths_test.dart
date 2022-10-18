import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_api/src/utils/image_paths.dart';

// ignore_for_file: require_trailing_commas

void main() {
  test('${ImagePathWeather.getPathWeatherIcon}', () async {
    final String pathIcon = ImagePathWeather.getPathWeatherIcon('11d');

    final isCorrectedPath = await File(pathIcon).exists();

    expect(isCorrectedPath, true);
  });

  test('${ImagePathWeather.packageName} is correct.', () async {
    expect(ImagePathWeather.packageName, 'open_weather_api',
        reason: 'Does not match current package name!');
  });
}
