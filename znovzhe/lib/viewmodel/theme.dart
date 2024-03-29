import 'package:ZnoNeZaHoramy/model/settings/general/generalModel.dart';
import 'package:ZnoNeZaHoramy/model/settings/settingsManager.dart';
import 'package:ZnoNeZaHoramy/view/settings/general/generalSettings.dart';

import 'package:flutter/material.dart';

import 'subjectIcons.dart';

class ThemeSelector {
  static final Color BACKGROUND_DARK = Color.fromARGB(255, 40, 40, 40);
  static final Color TEXT_COLOR_DARK = Colors.white70;
  static final Color BACKGROUND_WHITE = Colors.white;
  static final Color TEXT_COLOR_WHITE = Colors.black;

  static DarkMode darkMode = DarkMode.system;
  static bool isDark;
  ThemeData select(BuildContext context) {
    var counter = DefaultZNOCounter();
    var defaultZnoTime = counter.getZNOTime();
    darkMode = SettingsManager.getSetting<DarkModeSetting>()[0]
        .getSettingValue(context) as DarkMode;
    if (darkMode == DarkMode.system) {
      isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    } else {
      isDark = darkMode == DarkMode.dark;
    }
    ThemeData data;
    Color backgroundColor =
        isDark ? Color.fromARGB(255, 40, 40, 40) : Colors.white;
    Color textColor = isDark ? Colors.white70 : Colors.black;
    var textTheme = TextTheme(
        bodyText2: TextStyle(color: textColor),
        bodyText1: TextStyle(color: textColor),
        headline1: TextStyle(color: textColor),
        headline3: TextStyle(color: textColor),
        headline2: TextStyle(color: textColor),
        headline4: TextStyle(color: textColor),
        headline6: TextStyle(color: textColor),
        headline5: TextStyle(color: textColor));
    if ((defaultZnoTime.inDays / 30) > 5) {
      // BLUE ZONE
      var accent = isDark ? Colors.blue[700] : Colors.blueAccent;
      data = ThemeData(
          accentColor: Colors.blueAccent,
          backgroundColor: backgroundColor,
          scaffoldBackgroundColor: backgroundColor,
          textTheme: textTheme);

      return data;
    }
    if ((defaultZnoTime.inDays / 30) > 3) {
      // GREEEEEEEN ZONE
      var accent = isDark ? Colors.green : Colors.greenAccent;
      data = ThemeData(
          accentColor: accent,
          backgroundColor: backgroundColor,
          scaffoldBackgroundColor: backgroundColor,
          textTheme: textTheme);
      return data;
    }
    if ((defaultZnoTime.inDays / 30) > 1) {
      // YELLOW ONE
      var accent = isDark ? Colors.yellow[700] : Colors.yellow;
      data = ThemeData(
          accentColor: accent,
          backgroundColor: backgroundColor,
          scaffoldBackgroundColor: backgroundColor,
          textTheme: textTheme);
      return data;
    }
    if ((defaultZnoTime.inDays / 30) < 1) {
      // RED ONE
      var accent = isDark ? Colors.redAccent[600] : Colors.redAccent,
          data = ThemeData(
              accentColor: Colors.redAccent,
              backgroundColor: backgroundColor,
              scaffoldBackgroundColor: backgroundColor,
              textTheme: textTheme);
      return data;
    }
  }

  static Color getForegroundColor() {
    if (isDark) {
      return TEXT_COLOR_DARK;
    } else
      return TEXT_COLOR_WHITE;
  }
}

class DynamicState<T extends StatefulWidget> extends State<T> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError("Override the method build.");
  }
}
