[//]: # (TODO <img height="100" src="assets/weather_icons/@4/10d.png" width="100"/>)

[![pub_badge]][pub]
[![mit_license_badge]][mit_license]
![GitHub Repo stars][repo_star_badge]
![GitHub code size in bytes][code_size_badge]

## 🌦 weather_pack
A quick way to try out your UI ready weather conditions.

---

**Why choose this library?**

**_basic:_**
1. 🚲 Easy to use - you only need the APIKEY.
2. 🏝 Built-in geocoding - search for locations by assumed names or by coordinates.
3. 🩺 Various units of measurement - speed, temperature, pressure and cardinal points.
4. 🌤 There are original weather icons.

<details> <summary> <b><i>advanced:</i></b> (Click to open)</summary>
<ol>
<li>🔮 At least one release application is already based on this package. Therefore, there is an 
additional guarantee of security and timely updates of this package.</li>
<li>🔓 There is a method for checking your api for correctness.</li>
<li>🧱 It is very easy to customize data models. Create your own data models and take only what 
you need from the built-in ones.</li>
<li>🧾 The code is well documented and each class is labeled and decoded. There are unit tests 
for the main functions of the package.</li>
<li>🦺 Safe unpacking of types. If the server stops outputting values - your weather model 
will have a null field and the application will not crash.</li>
<li>🔧 This package has no unnecessary dependencies and contains minimal code. 
Also, all platforms are supported.</li>
</ol>
</details>

## Endpoints openweathermap.org
Let's agree to designate _Openweathermap_ as _**OWM**_.

Uses the following site endpoints [openweathermap.org](https://openweathermap.org/):

| Endpoint or Path                        | A class or method that uses this endpoint   | See more            |
|-----------------------------------------|---------------------------------------------|---------------------|
| api.openweathermap.org/data/2.5/weather | `WeatherService.currentWeatherByLocation`   | [current]           |
| api.openweathermap.org/data/2.5/onecall | `WeatherService.oneCallWeatherByLocation`   | [one-call-api]      |
| api.openweathermap.org/geo/1.0/direct   | `GeocodingService.getLocationByCityName`    | [geocoding-direct]  |
| api.openweathermap.org/geo/1.0/reverse  | `GeocodingService.getLocationByCoordinates` | [geocoding-reverse] |

<!-- Links -->
[current]: https://openweathermap.org/current
[one-call-api]: https://openweathermap.org/api/one-call-api
[geocoding-direct]: https://openweathermap.org/api/geocoding-api#direct
[geocoding-reverse]: https://openweathermap.org/api/geocoding-api#reverse

## Table of Contents

- [About the library](#🌦-weather_pack) 
- [Endpoints openweathermap.org](#endpoints-openweathermap.org) 
- [Installing](#installing) 
- [Getting Started](#getting-started) 
- [Usage weather service](#usage-weather-service) 
- [Usage geocoding service](#usage-geocoding-service) 
- [Usage units measure](#usage-units-measure)
- [Usage weather icons](#usage-weather-icons)
- [API key testing](#api-key-testing)
- [Features in development](#features-in-development)
- [Additional information](#additional-information)

## Installing

1. Add dependency to your `pubspec.yaml`:
   ```yaml
       dependencies:
          weather_pack: <latest_version>
    ```
2. Run the command: `flutter pub get`
3. Use in your code:
   ```dart
   import 'package:weather_pack/weather_pack.dart';
   ```

## Getting Started

The easiest way to get the current weather forecast

```dart
Future<void> main() async {
  const api = 'YOUR_APIKEY'; // TODO: change to your Openweathermap APIkey
  final wService = WeatherService(api);

  // get the current weather in Amsterdam
  final WeatherCurrent currently = await wService.currentWeatherByLocation(
      latitude: 52.374, longitude: 4.88969);
  
  print(currently);
}
```

You can also change the request language:

```dart
final lang = WeatherLanguage.arabic;

final wService = WeatherService(api, language: lang);
```

<details> <summary> <b><i>Supported languages:</i></b> (Click to open)</summary>

1. Afrikaans
2. Albanian
3. Arabic
4. Azerbaijani
5. Bulgarian
6. Catalan
7. Czech
8. Danish
9. German
10. Greek
11. English
12. Basque
13. Persian
14. Farsi
15. Finnish
16. French
17. Galician
18. Hebrew
19. Hindi
20. Croatian
21. Hungarian
22. Indonesian
23. Italian
24. Japanese
25. Korean
26. Latvian
27. Latvian
28. Macedonian
29. Norwegian
30. Dutch
31. Polish
32. Portuguese
33. Português Brasil
34. Romanian
35. Russian
36. Swedish
37. Slovak
38. Slovenian
39. Spanish
40. Serbian
41. Thai
42. Turkish
43. Ukrainian
44. Vietnamese
45. Chinese Simplified
46. Chinese Traditional
47. Zulu

</details>

According to OWM service ([See more](https://openweathermap.org/current#multi)):
> You can use the `lang` parameter to get the output in your language.
> 
> Translation is applied for the `city name` and `description` fields.

## Usage weather service

Now there are two weather models - `WeatherCurrent` and `WeatherOneCall`.

`WeatherOneCall` includes:
1. `WeatherCurrent`
2. `List<WeatherHourly>`
3. `List<WeatherMinutely>`
4. `List<WeatherDaily>`
5. `List<WeatherAlert>`

#### How to use?
You can get the weather in the following way:

```dart
final WeatherCurrent current = await wService
    .currentWeatherByLocation(latitude: 52.374, longitude: 4.88969);

final WeatherOneCall onecall = await wService
    .oneCallWeatherByLocation(latitude: 52.374, longitude: 4.88969);
```

## Usage geocoding service
`GeocodingService` is a service for easy location search when working with geographical names
and coordinates. Supports both the direct and reverse methods:
- Direct geocoding converts the specified name of a location or zip/post code into
  the exact geographical coordinates;
- Reverse geocoding converts the geographical coordinates into the names of the nearby locations;

You can find out more at this link: [Geocoding API OpenWeather](https://openweathermap.org/api/geocoding-api)

#### How to use?

Create `GeocodingService` in the following way:
```dart
final String cityName = 'suggested location name';
final String apiKey = 'your api key for OWM';

final GeocodingService gService = await GeocodingService(apiKey);
```

To find using place names use direct geocoding:
```dart
final List<PlaceGeocode> places = gService.getLocationByCityName(cityName);
```

or use reverse geocoding
```dart
final List<PlaceGeocode> places = gService.getLocationByCoordinates(latitude: 52.374, longitude: 4.88969);
```

## Usage units measure
By default, all weather models, e.g. `WeatherCurrent`, have measurable values of type `double`.
To display the data in a convenient format, it is necessary use the conversion method `value`
or `valueToString`:
```dart
void worksTempUnits({
  double temp = 270.78, // ex. received from [WeatherCurrent.temp]
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
```

_By and large, the `valueToString()` method is needed to display correctly in ui,
and the `value()` method is for accurate calculations._

There are several units of measurement:

| Units of measure | Class            | Supported units                     | Conversion |
|------------------|------------------|-------------------------------------|------------|
| Temperature      | `Temp`           | kelvin, celsius, fahrenheit         | +          |
| Speed            | `Speed`          | ms, mph, kph                        | +          |
| Pressure         | `Pressure`       | hectoPa, mbar, mmHg, kPa, atm, inHg | +          |
| Cardinal points  | `SideOfTheWorld` | n, ne, e, se, s, sw, w, nw          | +(another) |

**Tip**: The `SideOfTheWorld` enum contains a static method `fromDegrees()` for converting degrees
to cardinal directions.


## Usage weather icons

You can use weather icons provided by the OWM service. See more about [weather conditions](https://openweathermap.org/weather-conditions).

Icons are stored locally in this package at the path `assets/weather_icons/`. 
They are ordered according to [Declaring resolution-aware image assets](https://docs.flutter.dev/development/ui/assets-and-images#resolution-aware).
This reflects the following correspondences:

`100*100 - in default(implied resolution @1), 200x200 - @2, 300x300 - @3, 400x400 - @4`

with the preservation of image quality.

#### How to use?
Get the weather icon in a safe way:
```dart
Image getWeatherIcon(String weatherIcon) {
  return Image.asset(
    ImagePathWeather.getPathWeatherIcon(weatherIcon),
    filterQuality: FilterQuality.high, // optional
    package: ImagePathWeather.packageName,
  );
}
```

or to process it completely by hand:
```dart
Widget getWeatherIcon(WeatherCurrent weather) {
  return Image.asset(
    'assets/weather_icons/${weather.weatherIcon}.png', // icon path
    package: 'weather_pack', // name package
    filterQuality: FilterQuality.high, // optional
    errorBuilder: (c, e, s) => Text(e), // will return the widget in case of an error
  );
}
```

By and large, you can use the best quality regardless of platform resolution by specifying `@4` to path:
```dart
'assets/weather_icons/@4/$weatherIcon.png'
```

[//]: # (TODO: add note - получить или прямиком из сервиса OWM)
[//]: # (TODO: Получить статическим способом через `Enum`. А нужно ли?)

## API key testing
It is possible to test the API key. 
To do this, the `OWMApiTest` class has a method `isCorrectApiKey()`:
```dart
void worksTestedAPIkey({
  String testedAPIkey = 'Your_key',
}) async {

  // If the key is correct, it will return `true`
  final bool isCorrect = await OWMApiTest().isCorrectApiKey(testedAPIkey);
}
```

## Features in development
1. [ ] Getting weather by location name (built-in geocoding).

## Additional information

Made with ♥ Enjoy it!


<!--
## Sponsoring

I'm working on my packages on my free-time, but I don't have as much time as I would. 
If this package or any other package I created is helping you, please consider to sponsor me so 
that I can take time to read the issues, fix bugs, merge pull requests and add features 
to these packages.

## Sponsors

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, 
please fill an [issue][issue].  
If you fixed a bug or implemented a feature, please send a [pull request][pr].
 -->

<!-- Links -->
[mit_license_badge]: https://img.shields.io/badge/license-MIT-green?style=plastic
[mit_license]: https://github.com/PackRuble/weather_pack/blob/master/LICENSE
[code_size_badge]: https://img.shields.io/github/languages/code-size/PackRuble/weather_pack?style=plastic
[repo_star_badge]: https://img.shields.io/github/stars/PackRuble/weather_pack?style=social
[pub_badge]: https://img.shields.io/pub/v/weather_pack.svg?style=plastic
[pub]: https://pub.dev/packages/weather_pack
[buy_me_a_coffee]: https://www.buymeacoffee.com/<>
[issue]: https://github.com/PackRuble/weather_pack/issues
[pr]: https://github.com/PackRuble/weather_pack/pulls