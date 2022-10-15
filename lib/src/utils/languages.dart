// ignore_for_file: constant_identifier_names

/// You can use lang parameter to get the output in your language.
///
/// The contents of the [WeatherAlert.description] field will be translated.
///
/// [Multilingual support](https://openweathermap.org/api/one-call-api#multi)
///
/// OpenWeather support the following languages.
enum WeatherLanguage {
  afrikaans('af', 'Afrikaans'),
  albanian('al', 'Albanian'),
  arabic('ar', 'Arabic'),
  azerbaijani('az', 'Azerbaijani'),
  bulgarian('bg', 'Bulgarian'),
  catalan('ca', 'Catalan'),
  czech('cz', 'Czech'),
  danish('da', 'Danish'),
  german('de', 'German'),
  greek('el', 'Greek'),
  english('en', 'English'),
  basque('eu', 'Basque'),
  persian('fa', 'Persian'),
  farsi('fa', 'Farsi'),
  finnish('fi', 'Finnish'),
  french('fr', 'French'),
  galician('gl', 'Galician'),
  hebrew('he', 'Hebrew'),
  hindi('hi', 'Hindi'),
  croatian('hr', 'Croatian'),
  hungarian('hu', 'Hungarian'),
  indonesian('id', 'Indonesian'),
  italian('it', 'Italian'),
  japanese('ja', 'Japanese'),
  korean('kr', 'Korean'),
  latvian('la', 'Latvian'),
  lithuanian('lt', 'Latvian'),
  macedonian('mk', 'Macedonian'),
  norwegian('no', 'Norwegian'),
  dutch('nl', 'Dutch'),
  polish('pl', 'Polish'),
  portuguese('pt', 'Portuguese'),
  portugueseBrazilian('pt_br', 'Português Brasil'),
  romanian('ro', 'Romanian'),
  russian('ru', 'Russian'),
  swedish('sv', 'Swedish'), // in case of problems, replace with 'se'
  slovak('sk', 'Slovak'),
  slovenian('sl', 'Slovenian'),
  spanish('sp', 'Spanish'), // in case of problems, replace with 'es'
  serbian('sr', 'Serbian'),
  thai('th', 'Thai'),
  turkish('tr', 'Turkish'),
  ukrainian('ua', 'Ukrainian'), // in case of problems, replace with 'uk'
  vietnamese('vi', 'Vietnamese'),
  chineseSimplified('zh_cn', 'Chinese Simplified'),
  chineseTraditional('zh_tw', 'Chinese Traditional'),
  zulu('zu', 'Zulu');

  const WeatherLanguage(this.code, this.name);

  /// Language code for queries.
  final String code;

  /// Language full name.
  final String name;
}

/// Map of matching [WeatherLanguage.code] and [WeatherLanguage].
final Map<String, WeatherLanguage> codeAndLangMatching =
    <String, WeatherLanguage>{
  WeatherLanguage.afrikaans.code: WeatherLanguage.afrikaans,
  WeatherLanguage.albanian.code: WeatherLanguage.albanian,
  WeatherLanguage.arabic.code: WeatherLanguage.arabic,
  WeatherLanguage.azerbaijani.code: WeatherLanguage.azerbaijani,
  WeatherLanguage.bulgarian.code: WeatherLanguage.bulgarian,
  WeatherLanguage.catalan.code: WeatherLanguage.catalan,
  WeatherLanguage.czech.code: WeatherLanguage.czech,
  WeatherLanguage.danish.code: WeatherLanguage.danish,
  WeatherLanguage.german.code: WeatherLanguage.german,
  WeatherLanguage.greek.code: WeatherLanguage.greek,
  WeatherLanguage.english.code: WeatherLanguage.english,
  WeatherLanguage.basque.code: WeatherLanguage.basque,

  // farsi.code == persian.code
  WeatherLanguage.farsi.code: WeatherLanguage.farsi,
  WeatherLanguage.persian.code: WeatherLanguage.persian,

  WeatherLanguage.finnish.code: WeatherLanguage.finnish,
  WeatherLanguage.french.code: WeatherLanguage.french,
  WeatherLanguage.galician.code: WeatherLanguage.galician,
  WeatherLanguage.hebrew.code: WeatherLanguage.hebrew,
  WeatherLanguage.hindi.code: WeatherLanguage.hindi,
  WeatherLanguage.croatian.code: WeatherLanguage.croatian,
  WeatherLanguage.hungarian.code: WeatherLanguage.hungarian,
  WeatherLanguage.indonesian.code: WeatherLanguage.indonesian,
  WeatherLanguage.italian.code: WeatherLanguage.italian,
  WeatherLanguage.japanese.code: WeatherLanguage.japanese,
  WeatherLanguage.korean.code: WeatherLanguage.korean,
  WeatherLanguage.latvian.code: WeatherLanguage.latvian,
  WeatherLanguage.lithuanian.code: WeatherLanguage.lithuanian,
  WeatherLanguage.macedonian.code: WeatherLanguage.macedonian,
  WeatherLanguage.norwegian.code: WeatherLanguage.norwegian,
  WeatherLanguage.dutch.code: WeatherLanguage.dutch,
  WeatherLanguage.polish.code: WeatherLanguage.polish,
  WeatherLanguage.portuguese.code: WeatherLanguage.portuguese,
  WeatherLanguage.portugueseBrazilian.code: WeatherLanguage.portugueseBrazilian,
  WeatherLanguage.romanian.code: WeatherLanguage.romanian,
  WeatherLanguage.russian.code: WeatherLanguage.russian,

  // swedish.code == 'sv'
  WeatherLanguage.swedish.code: WeatherLanguage.swedish,
  'se': WeatherLanguage.swedish, // too swedish

  WeatherLanguage.slovak.code: WeatherLanguage.slovak,
  WeatherLanguage.slovenian.code: WeatherLanguage.slovenian,

  // spanish.code == 'sp'
  WeatherLanguage.spanish.code: WeatherLanguage.spanish,
  'es': WeatherLanguage.spanish, // too spanish

  WeatherLanguage.serbian.code: WeatherLanguage.serbian,
  WeatherLanguage.thai.code: WeatherLanguage.thai,
  WeatherLanguage.turkish.code: WeatherLanguage.turkish,

  // ukrainian.code == 'ua'
  WeatherLanguage.ukrainian.code: WeatherLanguage.ukrainian,
  'uk': WeatherLanguage.ukrainian, // too ukrainian

  WeatherLanguage.vietnamese.code: WeatherLanguage.vietnamese,
  WeatherLanguage.chineseSimplified.code: WeatherLanguage.chineseSimplified,
  WeatherLanguage.chineseTraditional.code: WeatherLanguage.chineseTraditional,
  WeatherLanguage.zulu.code: WeatherLanguage.zulu,
};
