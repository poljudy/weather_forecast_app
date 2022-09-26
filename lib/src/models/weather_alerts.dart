import '../utils/parse.dart';

/// Model represents national weather alerts.
///
/// This alerts from major national weather warning systems.
class WeatherAlert {
  WeatherAlert(
    this._weatherData, {
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> jsonData) {
    return WeatherAlert(
      jsonData,
      senderName: unpackString(jsonData, 'sender_name'),
      event: unpackString(jsonData, 'event'),
      start: unpackDate(jsonData, 'start'),
      end: unpackDate(jsonData, 'end'),
      description: unpackString(jsonData, 'description'),
      tags: (jsonData['tags'] as List?)?.map((s) => s as String).toList(),
    );
  }

  /// Name of the alert source.
  final String? senderName;

  /// Alert event name.
  final String? event;

  /// Date and time of the start of the alert.
  final DateTime? start;

  /// Date and time of the end of the alert.
  final DateTime? end;

  /// Description of the alert.
  final String? description;

  /// Type of severe weather.
  final List<String>? tags;

  /// The original JSON data from the API.
  final Map<String, dynamic> _weatherData;

  @override
  String toString() =>
      '${super.toString()}(event: $event, start: $start, end: $end)';

  /// The original JSON data from the API.
  Map<String, dynamic> toJson() => _weatherData;
}
