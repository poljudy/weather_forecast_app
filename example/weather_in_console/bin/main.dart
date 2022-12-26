import 'package:weather_in_console/weather_in_console.dart' as service_owm;

// Use command for run
// dart run --define="API_WEATHER=YOUR_APIKEY" bin/main.dart
// dart compile exe bin/main.dart --define="API_WEATHER=YOUR_APIKEY"

Future<void> main(List<String> arguments) async {
  await service_owm.getWeather();
}
