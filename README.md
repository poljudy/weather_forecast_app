![](assets/weather_icons/10d.png)

Название пакета - weather fast
Пакет предоставляет возможность использовать сервис погоды openweathermap.org.

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

Коллекция моделей погоды:
1. WeatherOneCall
2. WeatherAlert
3. WeatherCurrent
4. WeatherDaily
5. WeatherHourly
6. WeatherMinutely

## Использование иконок погодных условий
Для использования иконок погоды сделайте следующее:
```dart
final WeatherCurrent weather;

final icon = Image.asset(
        'assets/weather_icons/${weather.weatherIcon}.png',
        package: 'open_weather_api', //todo проследить за названием пакета
        filterQuality: FilterQuality.high,
        errorBuilder: (c, e, s) => Text(e),
      );
```
Рекомендуется:
1. Указать виджет при ошибке.
2. тодо сделать метод, где не потребуется указывать это вручную
3. тодо подумать над enum всех погодных условий
4. определить путь в отдельную переменную
Я схожусь к мнению, что нужно сделать отдельный метод получения иконок, причем не динамического характера

## Использование единиц конвертаций
По умолчанию, все погодные модели имеют лишь значения double.

Однако, существует несколько единиц конвертации:

| Units of measure | Class            | Supported units                     |
|------------------|------------------|-------------------------------------|
| Temperature      | `Temp`           | kelvin, celsius, fahrenheit         |
| Speed            | `Speed`          | ms, mph, kph                        |
| Pressure         | `Pressure`       | hectoPa, mbar, mmHg, kPa, atm, inHg |
| Cardinal points  | `SideOfTheWorld` | n, ne, e, se, s, sw, w, nw          |


## Использование иконок погоды
Для использования иконок погоды сделайте следующее:
получить динамическим способом:
```dart
final WeatherCurrent weather;

final icon = Image.asset(
        'assets/weather_icons/${weather.weatherIcon}.png',
        package: 'open_weather_api', //todo проследить за названием пакета
        filterQuality: FilterQuality.high,
        errorBuilder: (c, e, s) => Text(e),
      );
```

получить статическим способом: todo

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
