import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_api/src/services/geocoding/place_geocode_model.dart';

void main() {
  group('Creating $PlaceGeocode', () {
    test('PlaceGeocode.fromJson', () {
      // todo: заменить на чтение файла из json
      const String data =
          '{ "name": "moscow", "local_names": { "sg": "moscow", "ps": "مسکو", "sm": "moscow", "dv": "މޮސްކޯ", "cy": "moscfa", "ku": "moskow", "fo": "moskva", "ko": "모스크바", "wo": "mosku", "ascii": "moscow", "kw": "moskva", "kv": "мӧскуа", "ta": "மாஸ்கோ", "de": "moskau", "cu": "москъва", "tl": "moscow", "nl": "moskou", "ba": "мәскәү", "oc": "moscòu", "ia": "moscova", "id": "moskwa", "sv": "moskva", "es": "moscú", "so": "moskow", "nb": "moskva", "af": "moskou", "za": "moscow", "gl": "moscova - москва", "ab": "москва", "bg": "москва", "os": "мæскуы", "cs": "moskva", "bi": "moskow", "gd": "moscobha", "an": "moscú", "sl": "moskva", "dz": "མོསི་ཀོ", "ak": "moscow", "he": "מוסקווה", "ur": "ماسکو", "cv": "мускав", "kl": "moskva", "fr": "moscou", "my": "မော်စကိုမြို့", "vi": "mát-xcơ-va", "ss": "moscow", "no": "moskva", "hu": "moszkva", "et": "moskva", "hy": "մոսկվա", "fa": "مسکو", "na": "moscow", "sk": "moskva", "mn": "москва", "st": "moscow", "su": "moskwa", "el": "μόσχα", "kg": "moskva", "sh": "moskva", "mr": "मॉस्को", "kk": "мәскеу", "ie": "moskwa", "kn": "ಮಾಸ್ಕೋ", "ch": "moscow", "ms": "moscow", "ay": "mosku", "pl": "moskwa", "lt": "maskva", "zh": "莫斯科", "vo": "moskva", "is": "moskva", "am": "ሞስኮ", "lg": "moosko", "az": "moskva", "av": "москва", "ro": "moscova", "uk": "москва", "eo": "moskvo", "se": "moskva", "eu": "mosku", "hr": "moskva", "tk": "moskwa", "mt": "moska", "te": "మాస్కో", "ar": "موسكو", "be": "масква", "th": "มอสโก", "ty": "moscou", "jv": "moskwa", "tr": "moskova", "bo": "མོ་སི་ཁོ།", "nn": "moskva", "pt": "moscou", "ht": "moskou", "ug": "moskwa", "lv": "maskava", "tt": "мәскәү", "sq": "moska", "gn": "mosku", "br": "moskov", "mi": "mohikau", "io": "moskva", "ca": "moscou", "uz": "moskva", "gv": "moscow", "la": "moscua", "bn": "মস্কো", "ga": "moscó", "ml": "മോസ്കോ", "tg": "маскав", "da": "moskva", "bs": "moskva", "sr": "москва", "sw": "moscow", "it": "mosca", "ka": "მოსკოვი", "fy": "moskou", "ru": "москва", "fi": "moskova", "ja": "モスクワ", "yo": "mọsko", "ky": "москва", "ln": "moskú", "co": "moscù", "mg": "moskva", "ce": "москох", "li": "moskou", "mk": "москва", "iu": "ᒨᔅᑯ", "qu": "moskwa", "yi": "מאסקווע", "zu": "imoskwa", "feature_name": "moscow", "en": "moscow", "sc": "mosca", "wa": "moscou", "hi": "मास्को" }, "lat": 55.7504461, "lon": 37.6174943, "country": "ru", "state": "moscow" }';

      final place =
          PlaceGeocode.fromJson(jsonDecode(data) as Map<String, dynamic>);

      debugPrint(place.localNames.toString());

      expect(place.runtimeType, PlaceGeocode);
    });
  });
}
