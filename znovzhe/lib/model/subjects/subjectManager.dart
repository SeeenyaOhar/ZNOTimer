import 'package:ZnoNeZaHoramy/model/counter/counters.dart';
import 'package:ZnoNeZaHoramy/model/counter/znoCountersSave.dart';
import 'package:ZnoNeZaHoramy/model/subjects/subjects.dart';
import 'package:ZnoNeZaHoramy/view/main/main.dart';
import 'package:ZnoNeZaHoramy/viewmodel/subjectIcons.dart';
import 'package:flutter/material.dart';

class SubjectManager {
  static List<Subject> subjectsShown = [];
  static Map<Subject, bool> subjectsAvailable =
      Map(); // bool means if this kind of counter is already on the main screen

  static add(BuildContext context, Subject subject) async {
    var v = SortCounterManager().counters.where((x) => x.subject == subject);
    if (v.length == 0) {
      var znoTime = await SubjectValues.getZNODateTime(subject);
      var newCounter = ZnoCounter(subject, znoTime);
      SortCounterManager().add(newCounter);
      subjectsAvailable[subject] = true;
      ZnoCountersSave.save();
    }
  }

  static remove(BuildContext context, Subject subject) {
    var v = SortCounterManager()
        .counters
        .where((x) => x.subject == subject)
        .toList();
    if (v.length != 0) {
      SortCounterManager().remove(v[0]);
      subjectsAvailable[subject] = false;
      ZnoCountersSave.save();
    }
  }
}
