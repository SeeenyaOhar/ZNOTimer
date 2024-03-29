import 'dart:convert';

import 'package:ZnoNeZaHoramy/model/counter/counters.dart';
import 'package:ZnoNeZaHoramy/model/subjects/subjects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'languageManager.dart';

class SubjectValues {
  static SvgPicture getIcon(
    BuildContext context,
    Subject sub,
  ) {
    String assetPath = "";

    switch (sub) {
      case Subject.english:
        assetPath = "assets/english.svg";
        break;
      case Subject.ukrainianLanguageLiterature:
        assetPath = "assets/ukrainian language.svg";
        break;
      case Subject.math:
        assetPath = "assets/math.svg";
        break;
      case Subject.biology:
        assetPath = "assets/biology.svg";
        break;
      case Subject.history:
        assetPath = "assets/history.svg";
        break;
      case Subject.physics:
        assetPath = "assets/physics.svg";
        break;
      case Subject.germanLanguage:
        assetPath = "assets/german.svg";
        break;
      case Subject.spanishLanguage:
        assetPath = "assets/spanish.svg";
        break;
      case Subject.geography:
        assetPath = "assets/geography.svg";
        break;
      case Subject.chemistry:
        assetPath = "assets/chemistry.svg";
        break;
      case Subject.frenchLanguage:
        assetPath = "assets/french.svg";
        break;
      case Subject.firstOne:
        throw new ArgumentError("You can't get an icon from Subject.firstOne");
        break;
    }
    if (assetPath != "") {
      return SvgPicture.asset(assetPath,
          color: Theme.of(context).accentColor,
          width: 32,
          height: 32,
          colorBlendMode: BlendMode.srcIn);
    } else
      return SvgPicture.asset("assets/english.svg",
          color: Theme.of(context).accentColor,
          width: 32,
          height: 32,
          colorBlendMode: BlendMode.srcIn);
  }

  static String getSubjectName(BuildContext context, Subject _subject) {
    switch (_subject) {
      case Subject.english:
        return LocalizationTool.of(context).english;
        break;
      case Subject.ukrainianLanguageLiterature:
        return LocalizationTool.of(context).ukrainianLL;
        break;
      case Subject.math:
        return LocalizationTool.of(context).math;
        break;
      case Subject.biology:
        return LocalizationTool.of(context).biology;
        break;
      case Subject.history:
        return LocalizationTool.of(context).history;
        break;
      case Subject.physics:
        return LocalizationTool.of(context).physics;
        break;
      case Subject.germanLanguage:
        return LocalizationTool.of(context).germanLanguage;
        break;
      case Subject.spanishLanguage:
        return LocalizationTool.of(context).spanishLanguage;
        break;
      case Subject.geography:
        return LocalizationTool.of(context).geography;
        break;
      case Subject.chemistry:
        return LocalizationTool.of(context).chemistry;
        break;
      case Subject.frenchLanguage:
        return LocalizationTool.of(context).frenchLanguage;
        break;
      case Subject.firstOne:
        throw new ArgumentError(
            "First one should only apppear on the main screen, it's a special value.");
        break;
    }
  }

  static Future<DateTime> getZNODateTime(Subject _subject) async {
    DateTime resultDate;
    var znoYear = SortCounterManager().znoYear;

    String futureContent =
        await rootBundle.loadString("assets/subjectschedule.json");
    List subjects = jsonDecode(futureContent);
    String subjectStr = _subject.toString().split(".")[1];
    subjects.forEach((element) {
      if (element["subject"] == subjectStr) {
        resultDate = DateTime(znoYear, element["month"], element["day"]);
      }
    });

    return resultDate;
  }
}

class DefaultZNOCounter {
  // This is a default znoCounter(counts up to the 20th of may)
  Duration getZNOTime() {
    var znoYear = 0;

    znoYear = SortCounterManager().znoYear;
    var znoTime = DateTime(znoYear, 5, 21, 9);
    var timeNow = DateTime.now();
    return znoTime.difference(timeNow);
  }
}
