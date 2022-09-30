import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../api/weather_api.dart';
import '../api/weather_api_error.dart';

/// Интерфейс предназначен для единых запросов и обработки ошибок.
mixin OWMClient {
  late final http.Client _httpClient;

  static const int _statusOk = 200;
  static const int _statusOkTestApi = 400;
  static const int _statusApiError = 401;

  /// Make a service request and get a response-data from the service OWM.
  ///
  /// Also handles errors.
  Future<T> getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      final http.Response response = await _httpClient.get(uri);

      switch (response.statusCode) {
        case 200:
          final dynamic data = json.decode(response.body);
          return builder(data);
        default:
          throw OwmApiException(response.statusCode, response.body);
      }
    } on SocketException catch (_) {
      throw const OwmApiException(0, 'No Internet connection');
    }
    // todo add throw TimeoutException()
  }

  /// Check for a valid api key OWM.
  static Future<bool> isCorrectApi(String yourApi) async {
    final Uri uri = OpenWeatherMapAPI.uriTestApikey(yourApi);

    final http.Response response = await http.Client().get(uri);

    if (response.statusCode == _statusOk ||
        response.statusCode == _statusOkTestApi) {
      return true;
    } else if (response.statusCode == _statusApiError) {
      return false;
    }
    return false;
  }
}
