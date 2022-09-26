mixin EnumValue {
  /// Converts value to double with [precision] and [Enum].
  ///
  /// To Do implements with use switch case.
  double value(double value, [int precision = 1]);

  /// Converts [value] to the minimum number of decimal places. Up to 0.
  ///
  /// Examples:
  /// ```dart
  /// (5.1234).fromMSToString(precision = 0);  // 5
  /// (5.123456).fromMSToString(precision = 1);  // 5.1
  /// (5.666666).fromMSToString(precision = 6);  // 5.666667
  /// (5.1).fromMSToString(precision = 6);  // 5.100000
  /// ```
  String valueToString(double value, [int precision = 0]) =>
      this.value(value, precision).toStringAsFixed(precision);
}

// enum RTemp with EnumValue {
//   kelvin('Kelvin', 'K'),
//   celsius('Celsius', '°C'),
//   fahrenheit('Fahrenheit', '°F');
//
//   const RTemp(this.name, this.abbr);
//
//   final String name;
//   final String abbr;
//
//   @override
//   double value(double value, [int precision = 1]) {
//     switch (this) {
//       case RTemp.celsius:
//         return double.parse((value - 273.15).toStringAsFixed(precision));
//       case RTemp.fahrenheit:
//         return double.parse((value * 1.8 - 459.67).toStringAsFixed(precision));
//       case RTemp.kelvin:
//       default:
//         return double.parse(value.toStringAsFixed(precision));
//     }
//   }
// }

// todo add mixin EnumValue.
/// Represents units of temperature measurement.
enum Temp {
  kelvin('Kelvin', 'K'),
  celsius('Celsius', '°C'),
  fahrenheit('Fahrenheit', '°F');

  const Temp(this.name, this.abbr);

  final String name;
  final String abbr;

  /// Translating temperature from Kelvin to another.
  ///
  /// Default, temperature in Kelvin.
  static double fromKelvinTo(Temp toTemp, double value, [int precision = 1]) {
    switch (toTemp) {
      case Temp.celsius:
        return double.parse((value - 273.15).toStringAsFixed(precision));
      case Temp.fahrenheit:
        return double.parse((value * 1.8 - 459.67).toStringAsFixed(precision));
      case Temp.kelvin:
      default:
        return double.parse(value.toStringAsFixed(precision));
    }
  }

  /// Translating temperature from Kelvin to another and
  /// return String to a specified precision.
  ///
  /// Default, temperature in Kelvin.
  static String fromKelvinToString(Temp toTemp, double value,
          [int precision = 0]) =>
      fromKelvinTo(toTemp, value).toStringAsFixed(precision);

  /// Точка, при которой замерзает вода исходя из системы счисления.
  static double getMeltingPoint(Temp toTemp) {
    switch (toTemp) {
      case Temp.celsius:
        return 0;
      case Temp.fahrenheit:
        return 32;
      case Temp.kelvin:
      default:
        return 273.15;
    }
  }
}

/// Represents units of speed.
/// * ms - meters per second
/// * mph - miles per hour
/// * kph - kilometers per hour
enum Speed with EnumValue {
  ms('meters per second', 'm/s'),
  mph('miles per hour', 'mph'),
  kph('kilometers per hour', 'km/h');

  const Speed(this.name, this.abbr);

  final String name;
  final String abbr;

  /// Translating speed from meter/sec to another.
  ///
  /// Default, speed in meter/sec (ms)
  @override
  double value(double value, [int precision = 1]) {
    switch (this) {
      case Speed.kph:
        return double.parse((value * 3.6).toStringAsFixed(precision));
      case Speed.mph:
        return double.parse((value * 2.2369).toStringAsFixed(precision));
      case Speed.ms:
      default:
        return double.parse(value.toStringAsFixed(precision));
    }
  }
}

/// Represents units of pressure measurement.
enum Pressure with EnumValue {
  hectoPa('Hectopascal', 'hPa'), // Гектопаскали -- гПа
  mbar('Millibar ', 'mbar'), // МиллиБары -- мБар
  mmHg('Millimetre of mercury',
      'mmHg'), // Миллиметры ртутного столба -- мм. рт. ст.
  kPa('Kilopascal', 'kPa'), // Килопаскали -- кПа
  atm('Atmosphere', 'atm'), // Атмосферы -- атм
  inHg('Inch of mercury', 'inHg'); // Дюймы ртутного столба -- дюйм рт. ст.

  const Pressure(this.name, this.abbr);

  final String name;
  final String abbr;

  /// Translating pressure from hPa to another.
  ///
  /// Default, pressure in hectopascals.
  @override
  double value(double value, [int precision = 1]) {
    switch (this) {
      case Pressure.mmHg:
        return double.parse((value * 0.75006).toStringAsFixed(precision));
      case Pressure.kPa:
        return double.parse((value * 0.1).toStringAsFixed(precision));

      // in order to improve informativeness relative to other units of measurement,
      // we increase the precision by 2 orders of magnitude
      case Pressure.atm:
        return double.parse((value * 0.00099).toStringAsFixed(precision + 2));
      case Pressure.inHg:
        return double.parse((value * 0.02953).toStringAsFixed(precision));
      case Pressure.mbar:
      case Pressure.hectoPa:
      default:
        return value;
    }
  }
}

/// Стороны света.
enum SideOfTheWorld {
  // cardinal point
  north('N', 'North'),
  northEast('NE', 'North-East'),
  east('E', 'East'),
  southEast('SE', 'South-East'),
  south('S', 'South'),
  southWest('SW', 'South-West'),
  west('W', 'West'),
  northWest('NW', 'North-West');

  const SideOfTheWorld(this.abbr, this.name);

  final String abbr;
  final String name;

  /// Функция перевода из градусов в стороны света.
  static SideOfTheWorld fromDegrees(double deg) {
    assert(0.0 <= deg && deg <= 360.0);

    if (22.5 < deg && deg < 157.5) {
      if (22.5 < deg && deg < 67.5) {
        return northEast;
      } else if (67.5 < deg && deg < 112.5) {
        return east;
      } else if (112.5 < deg && deg < 157.5) {
        return southEast;
      }
    }

    if (202.5 < deg && deg < 337.5) {
      if (202.5 < deg && deg < 247.5) {
        return southWest;
      } else if (247.5 < deg && deg < 292.5) {
        return west;
      } else if (292.5 < deg && deg < 337.5) {
        return northWest;
      }
    }

    if ((337.5 < deg && deg < 360.0) || (0 < deg && deg < 22.5)) {
      return north;
    } else if (157.5 < deg && deg < 202.5) {
      return south;
    }

    if (deg == 22.5 || deg == 337.5) return north;
    if (deg == 67.5 || deg == 112.5) return east;
    if (deg == 157.5 || deg == 202.5) return south;
    if (deg == 247.5 || deg == 292.5) return west;

    return north; // todo - error?
  }
}
