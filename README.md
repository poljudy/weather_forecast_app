<img height="100" src="assets/weather_icons/@4/10d.png" width="100"/>

Название пакета - weather fast
## weather fast
Быстрый способ опробовать ваш ui готовыми погодными условиями.

Использует api сайта [openweathermap.org](https://openweathermap.org/)

## About this library
Условимся обозначать сервис openweathermap (далее OWM)
Преимущества пакета:
1. Безопасная распаковка типов. Если сервер перестанет выдавать значения - ваша модель погоды будет
   иметь значение null и приложение не рухнет.
2. Вы можете подстроить модель под себя, расширившись от класса погоды. Возможно, лишние величины
   вам не нужны.
3. На данном пакете уже основано как минимум одно приложение, выпущенное в релиз. Поэтому
   существует дополнительная гарантия безопасности и своевременного обновления данного пакета.
4. Легко начать использовать.
5. Есть удобные величины измерения скорости, температуры, давления и  сторон света, а также
   имеется конвертация величин.
6. *Планируется дать более удобный обработчик некоторых погодных параметров.
7. *Планируется внедрить тестовые получения моделей погоды для работы в режиме отладки
8. В комплекте с пакетом имеются иконки, взятые из оригинального api.
9. Пакет не имеет лишних зависимостей.

## Table of Contents

- [Getting Started](#getting-started) 
- [Usage weather icons](#usage-weather-icons)
- [Usage units measure](#usage-units-measure)
- [Main Features](#main-features)
  - [Features](#features)
  - [Additional information](#additional-information)

- Давайте начнем

Название пакета - weather fast
Пакет предоставляет возможность использовать сервис погоды openweathermap.org.


## Main components of the library
1. Geocoding service -

## Getting Started


Коллекция моделей погоды:
1. WeatherCurrent
2. WeatherOneCall
3. WeatherAlert
4. WeatherDaily
5. WeatherHourly
6. WeatherMinutely

## Usage weather icons

Вы можете использовать иконки погодных условий, предоставляемые сервисом OWM
([weather-conditions](https://openweathermap.org/weather-conditions)).

Иконки хранятся локально в данном пакете по пути `assets/weather_icons/`. Причем, упорядочены в 
соответствие с [Declaring resolution-aware image assets](https://docs.flutter.dev/development/ui/assets-and-images#resolution-aware).
Соответствуют 100*100 - in default(подразумевается разрешение @1), 200x200 - @2, 300x300 - @3, 400x400 - @4 
с сохранением качества изображений.

### How to use?
1. Получить иконку погоды безопасным способом:
```dart
Image getWeatherIcon(String weatherIcon) {
  return Image.asset(
    ImagePathWeather.getPathWeatherIcon(weatherIcon),
    filterQuality: FilterQuality.high, // optional
    package: ImagePathWeather.packageName,
  );
}
```
или обработать полностью вручную:
```dart
Widget getWeatherIcon(WeatherCurrent weather) {
  return Image.asset(
    'assets/weather_icons/${weather.weatherIcon}.png', // icon path
    package: 'open_weather_api', // name package
    filterQuality: FilterQuality.high, // optional
    errorBuilder: (c, e, s) => Text(e), // will return the widget in case of an error
  );
}
```
или прямиком из сервиса OWM **todo**
2. Получить статическим способом: ***todo***
Если что-либо не получается, не отчаивайтесь и попытайтесь получить иконки прямо с сервиса OWM. todo

Рекомендуется:
1. Указать виджет при ошибке.
2. тодо сделать метод, где не потребуется указывать это вручную
3. тодо подумать над enum всех погодных условий
4. определить путь в отдельную переменную
Я схожусь к мнению, что нужно сделать отдельный метод получения иконок, причем не динамического характера

[//]: # (## Использование единиц конвертаций)
## Usage units measure
По умолчанию, все погодные модели имеют лишь значения double.

Однако, существует несколько единиц конвертации:

| Units of measure | Class            | Supported units                     |
|------------------|------------------|-------------------------------------|
| Temperature      | `Temp`           | kelvin, celsius, fahrenheit         |
| Speed            | `Speed`          | ms, mph, kph                        |
| Pressure         | `Pressure`       | hectoPa, mbar, mmHg, kPa, atm, inHg |
| Cardinal points  | `SideOfTheWorld` | n, ne, e, se, s, sw, w, nw          |


## Usage of geocoding service

`GeocodingService` is a service for easy location search when working with geographical names 
and coordinates. Supports both the direct and reverse methods:
- Direct geocoding converts the specified name of a location or zip/post code into 
the exact geographical coordinates;
- Reverse geocoding converts the geographical coordinates into the names of the nearby locations;

You can find out more at this link: [Geocoding API OpenWeather](https://openweathermap.org/api/geocoding-api)

#### How to use?

To find using place names use this (direct geocoding):
```dart
final String cityName = 'suggested location name';
final String apiKey = 'your api key for OWM';

final List<PlaceGeocode> places = await GeocodingService(apiKey).getLocationByCityName(cityName);
```

Класс предоставляет доступ к службе геокодирования городов.
Поддерживает как прямой, так и обратный методы:
Прямое геокодирование преобразует указанное название местоположения или почтовый индекс в точные географические координаты;
Обратное геокодирование преобразует географические координаты в названия близлежащих мест;

## Main Features
## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
