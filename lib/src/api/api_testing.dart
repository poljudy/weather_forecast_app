import 'package:http/http.dart' as http;

import 'api.dart';

/// A class to help check your APIkey.
class OWMApiTest {
  // ignore: public_member_api_docs
  OWMApiTest();

  final http.Client _httpClient = http.Client();

  static const int _statusOkTestApi = 400;

  /// Check for a valid APIkey OWM.
  Future<bool> isCorrectApiKey(String yourApi) async {
    final Uri uri = OWMApi.uriTestApikey(yourApi);

    final http.Response response = await _httpClient.get(uri);

    if (response.statusCode == _statusOkTestApi) {
      return true;
    }

    return false;
  }
}
