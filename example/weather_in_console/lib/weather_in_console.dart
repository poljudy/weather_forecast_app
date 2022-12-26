import 'dart:io';

import 'package:interact/interact.dart';
import 'package:weather_pack/weather_pack.dart';

// TODO: If you do not use the `--define="API_WEATHER=YOUR_APIKEY"` flag,
//  provide the key here instead of 'null'
const String _apiKey = null ?? String.fromEnvironment('API_WEATHER');

final _wService = WeatherService(_apiKey, language: WeatherLanguage.russian);
final _gService = GeocodingService(_apiKey);

/// Получить погодные данные.
Future<void> getWeather() async {
  stdout.writeln(' ✨ Добро пожаловать в погодный сервис! ✨ \n');

  await _checkApiKey(_apiKey);

  bool isRepeat = true;

  do {
    PlaceGeocode? city;
    do {
      final String desiredPlace = _inputCity();
      city = await _selectCity(desiredPlace);
    } while (city == null);

    final _TypeWeather typeWeather = _selectTypeWeather();

    await _getWeather(city, typeWeather);

    isRepeat = _repeat();
  } while (isRepeat == true);

  exit(0);
}

Future<void> _checkApiKey(String apiKey) async {
  final bool isCorrectApiKey = await OWMApiTest().isCorrectApiKey(_apiKey);

  if (isCorrectApiKey) {
    stdout.writeln(' 🗝 Ключ подходит для этого замка ^_~');
  } else {
    stdout.writeln(' ❌ Api-ключ не подходит!');
    exit(1);
  }
}

enum _TypeWeather {
  hourly('Почасовая погода'),
  current('Текущая погода'),
  daily('Погода на 7 дней'),
  alerts('Погодные предупреждения'),
  all('Все данные');

  const _TypeWeather(this.name);

  final String name;
}

bool _repeat() {
  return Confirm(
    prompt: 'Узнать погоду другого местоположения?',
    defaultValue: true,
    waitForNewLine: true,
  ).interact();
}

Future<PlaceGeocode?> _selectCity(String desiredPlace) async {
  final spinner = Spinner(
    icon: ' 🏡 ',
    rightPrompt: (done) => done
        ? 'Вы ввели местоположение'
        : 'Получаем список доступных местоположений...',
  ).interact();

  final List<PlaceGeocode> places =
      await _gService.getLocationByCityName(desiredPlace);

  spinner.done();

  if (places.isEmpty) {
    stdout.writeln('Но "$desiredPlace" не найдено <(＿　＿)>');
    return null;
  }

  final index = Select(
    prompt: 'Выберите местоположение из списка?',
    options: places.map((PlaceGeocode place) {
      final result = StringBuffer();

      if (place.countryCode != null) {
        result.write('${place.countryCode}: ');
      }

      if (place.state != null) {
        result.write('${place.state}, ');
      }

      if (place.name != null) {
        result.write('${place.name}');
      }

      return result.toString();
    }).toList(),
  ).interact();

  return places[index];
}

/// Получить местоположение, по которому пользователь хочет узнать погоду.
String _inputCity() {
  final input = Input(
    prompt: 'Ваше местоположение?',
  ).interact();

  if (input.isEmpty) {
    final isResume = Confirm(
      prompt: 'Местоположение не указано. Попробовать ещё раз?',
      defaultValue: true,
      waitForNewLine: true,
    ).interact();

    return isResume ? _inputCity() : exit(0);
  } else {
    return input;
  }
}

/// Выбрать тип погодных данных.
_TypeWeather _selectTypeWeather() {
  final index = Select(
    prompt: 'Какие погодные данные предоставить?',
    options: _TypeWeather.values.map((e) => e.name).toList(),
    initialIndex: 1,
  ).interact();

  return _TypeWeather.values[index];
}

/// Получить погоду [WeatherCurrent].
Future<WeatherCurrent> _getWeatherCurrent(PlaceGeocode city) async {
  return _wService.currentWeatherByLocation(
    latitude: city.latitude ?? 0.0,
    longitude: city.longitude ?? 0.0,
  );
}

/// Получить погоду [WeatherOneCall].
Future<WeatherOneCall> _getWeatherOneCall(PlaceGeocode city) async {
  return _wService.oneCallWeatherByLocation(
    latitude: city.latitude ?? 0.0,
    longitude: city.longitude ?? 0.0,
  );
}

/// Получить погоду и распечатать результаты.
Future<void> _getWeather(PlaceGeocode city, _TypeWeather typeWeather) async {
  final gift = Spinner(
    icon: ' 🌤 ',
    rightPrompt: (done) =>
        done ? 'Вот награда за терпение' : 'Получаем погодные данные...',
  ).interact();

  late WeatherCurrent current;
  late WeatherOneCall oneCall;

  if (typeWeather == _TypeWeather.current) {
    current = await _getWeatherCurrent(city);
  } else {
    oneCall = await _getWeatherOneCall(city);
  }

  gift.done();

  switch (typeWeather) {
    case _TypeWeather.hourly:
      _printHourly(oneCall.hourly);
      break;
    case _TypeWeather.current:
      _printCurrent(current);
      break;
    case _TypeWeather.daily:
      _printDaily(oneCall.daily);
      break;
    case _TypeWeather.alerts:
      _printAlerts(oneCall.alerts);
      break;
    case _TypeWeather.all:
      _printAlerts(oneCall.alerts);
      _printHourly(oneCall.hourly);
      _printDaily(oneCall.daily);
      break;
  }
}

void _printAlerts(List<WeatherAlert>? alerts) {
  if (alerts?.isEmpty ?? true) {
    stdout.writeln('Предупреждений нет');
    return;
  }
  stdout.writeln('====================');
  for (final a in alerts!) {
    stdout.write('''
Событие:   ${a.event}
Описание:  ${a.description}
Начало:    ${a.start}
Окончание: ${a.end}
=====
''');
  }
}

void _printDaily(List<WeatherDaily>? daily) {
  if (daily?.isEmpty ?? true) {
    stdout.writeln('Погода на 7 дней -> Нет данных');
    return;
  }

  stdout.writeln('====================');
  for (final d in daily!) {
    stdout.write('''
${d.date!.day}.${d.date!.month}.${d.date!.year}
${d.weatherDescription}
Температура ( утром: ${d.tempMorning} K, днём: ${d.tempDay} K, вечером: ${d.tempEvening} K, ночью: ${d.tempNight} K )
Восход и закат солнца ( ${d.sunrise} --> ${d.sunset} )
Восход и закат луны   ( ${d.moonrise} --> ${d.moonset} )
Скорость ветра ( ${d.windSpeed} м/с )
Давление  ( ${d.pressure} гПа )
Влажность ( ${d.humidity} % )
Ультрафиолетовый индекс ( ${d.uvi} )
Вероятность осадков ( ${d.pop} % )
=====
''');
  }
}

void _printHourly(List<WeatherHourly>? hourly) {
  if (hourly?.isEmpty ?? true) {
    stdout.writeln('Почасовая погода -> Нет данных');
    return;
  }

  stdout.writeln('====================');
  for (final h in hourly!) {
    final date =
        ' ${h.date?.day.toString().padLeft(2, '0')}.${h.date?.month.toString().padLeft(2, '0')} ${h.date?.hour.toString().padLeft(2, '0')}:00';

    stdout.write('''
 ($date ${h.weatherMain?.padRight(20)} ${h.temp.toString().padRight(6, '0')} K, ${h.pop.toString().padRight(4, '0')} % осадков )
''');
  }
}

void _printCurrent(WeatherCurrent current) {
  final DateTime? date = current.date;

  const pressureUnits = Pressure.mmHg;
  const tempUnits = Temp.celsius;
  const speedUnits = Speed.kph;

  final temp = tempUnits.valueToString(current.temp!, 2);
  final tempFeelsLike = tempUnits.valueToString(current.tempFeelsLike!, 2);

  final windSpeed = speedUnits.valueToString(current.windSpeed!, 1);
  final windGust = speedUnits.valueToString(current.windGust ?? 0.0, 2);

  stdout.write('''
=====Сегодня=====
${date?.day}.${date?.month}.${date?.year} ${date?.hour}ч:${date?.minute}м
${current.weatherDescription}
Температура $temp ${tempUnits.abbr}, Ощущается как $tempFeelsLike ${tempUnits.abbr}
Скорость ветра - $windSpeed ${speedUnits.abbr}, порывы до $windGust ${speedUnits.abbr}
Направление ветра: ${SideOfTheWorld.fromDegrees(current.windDegree!).name}
Давление  ( ${pressureUnits.valueToString(current.pressure!)} ${pressureUnits.abbr} )
Влажность ( ${current.humidity} % )
Ультрафиолетовый индекс ( ${current.uvi} )
Восход и закат солнца   ( ${current.sunrise} --> ${current.sunset} )
=================
''');
}
