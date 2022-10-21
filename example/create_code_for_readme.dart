import 'package:weather_pack/weather_pack.dart';

// ignore_for_file: type=lint, dead_code, unused_local_variable

main() async {
  if (false) printAllSupportedLanguages();
  if (false) worksTempUnits();
  if (false) getWeatherEasyWay();
}

void worksGeocodeService({
  String api = 'Your_APIkey',
}) async {
  final gService = GeocodingService(api);

  final List<PlaceGeocode> places = await gService.getLocationByCoordinates(
      latitude: 52.374, longitude: 4.88969);

  print(places);
}

Future<void> getWeatherEasyWay({
  String api = 'Your_APIkey',
  WeatherLanguage lang = WeatherLanguage.italian,
}) async {
  final wService = WeatherService(api, language: lang);

  final WeatherCurrent current = await wService.currentWeatherByLocation(
      latitude: 52.374, longitude: 4.88969);

  final WeatherOneCall onecall = await wService.oneCallWeatherByLocation(
      latitude: 52.374, longitude: 4.88969);

  print(current);
  print(onecall);
}

void printAllSupportedLanguages() {
  WeatherLanguage.values
      .forEach((lang) => print('${lang.index}. ${lang.name}'));
}

void worksTempUnits({
  double temp = 270.78, // received from [WeatherCurrent.temp]
  int precision = 3,
  Temp unitsMeasure = Temp.celsius,
}) {
  // The default temperature is measured in Kelvin of the `double` type.
  // We need the temperature to be displayed in Celsius to 3 decimal places

  print(unitsMeasure.value(temp, precision)); // `-2.37` type `double`
  print(unitsMeasure.valueToString(temp, precision)); // `-2.370` type `String`

  // if precision is 0:
  print(unitsMeasure.value(temp, 0)); // `-2.0` type `double`
  print(unitsMeasure.valueToString(temp, 0)); // `-2` type `String`
}

void worksTestedAPIkey({
  String testedAPIkey = 'Your_key',
}) async {
  // If the key is correct, it will return `true`
  final bool isCorrect = await OWMApiTest().isCorrectApiKey(testedAPIkey);
}
