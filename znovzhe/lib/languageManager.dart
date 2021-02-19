import "package:flutter/foundation.dart";
import 'package:flutter/material.dart';
import 'package:znovzhe/main.dart';

class LocalizationTool {
  LocalizationTool(this.locale);
  final Locale locale;

  String get english => getValue("english");

  String get physics => getValue("physics");

  String get history => getValue("history");

  String get biology => getValue("biology");

  String get math => getValue("math");

  String get ukrainianLL => getValue("ukrainianLL");

  String get germanLanguage => getValue("germanLanguage");

  String get geography => getValue("geography");

  String get spanishLanguage => getValue("spanishLanguage");

  String get chemistry => getValue("chemistry");

  String get frenchLanguage => getValue("frenchLanguage");

  String getValue(String key) {
    return _localizedValues[locale.languageCode][key];
  }

  static LocalizationTool of(BuildContext context) {
    return Localizations.of<LocalizationTool>(context, LocalizationTool);
  }
  // HERE YOU GO WITH THE STRINGS
  // String get [stringName] => getValue([stringName]);
  //

  String get znoTimeLeftTitle => getValue("znoTimeLeftTitle");
  get months1 => getValue("&month1");
  get months234 => getValue("&month234");
  get months5 => getValue("&month5");
  get days1 => getValue("&days1");
  get days234 => getValue("&days234");
  get days5 => getValue("&days5");

  static Map<String, Map<String, String>> _localizedValues = {
    "ua": {
      "znoTimeLeftTitle": "Залишилось до ЗНО: ",
      "&month1": "місяць",
      "&month234": "місяці",
      "&month5" : "місяців",
      "&days1": "день",
      "&days234": "дня",
      "&days5": "днів",
      "english": "Англійська мова",
      "physics" : "Фізика",
      "history" : "Історія України",
      "biology" : "Біологія",
      "math" : "Математика",
      "ukrainianLL" : "Українська мова (та література)",
      "germanLanguage" : "Німецька мова",
      "geography" : "Географія",
      "spanishLanguage" : "Іспанська мова",
      "chemistry" : "Хімія",
      "frenchLanguage" : "Французька мова"
    },
    'en': {
      "znoTimeLeftTitle": "Time left to ZNO: ",
      "&month1": "month",
      "&month2": "months",
      "&month234": "months",
      "&month5" : "months",
      "&days1": "day",
      "&days234": "days",
      "&days5": "days",
      "english" : "English",
      "physics" : "Physics",
      "history" : "History of Ukraine",
      "biology" : "Biology",
      "math" : "Math",
      "ukrainianLL" : "The Ukrainian Language(and Ukrainian Literature)",
      "germanLanguage" : "The German Language",
      "geography" : "Geography",
      "spanishLanguage" : "The Spanish Language",
      "chemistry" : "Chemistry",
      "frenchLanguage" : "The French Language"
      },
    'ru': {
      "znoTimeLeftTitle": "Осталось к ЗНО: ",
      "&month1": "месяц",
      "&month234": "месяца",
      "&month5" : "месяцев",
      "&days1": "день",
      "&days234": "дня",
      "&days5": "дней",
      "english" : "Английский язык",
      "physics" : "Физика",
      "history" : "История Украины",
      "biology" : "Биология",
      "math" : "Математика",
      "ukrainianLL" : "Украинский язык(и украинская литература)",
      "germanLanguage" : "Немецкий язык",
      "geography" : "География",
      "spanishLanguage" : "Испанский язык",
      "chemistry" : "Химия",
      "frenchLanguage" : "Французкий язык"
    },
  };

  
}

class ZnoVzheLocalizationsDelegate
    extends LocalizationsDelegate<LocalizationTool> {
  const ZnoVzheLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ru', 'ua'].contains(locale.languageCode);

  @override
  Future<LocalizationTool> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<LocalizationTool>(LocalizationTool(locale));
  }

  @override
  bool shouldReload(ZnoVzheLocalizationsDelegate old) => false;
}
