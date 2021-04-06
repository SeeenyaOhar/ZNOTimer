import 'package:ZnoNeZaBarom/model/subjects/subjectManager.dart';
import 'package:ZnoNeZaBarom/model/subjects/subjects.dart';
import 'package:ZnoNeZaBarom/viewmodel/theme.dart';
import 'package:ZnoNeZaBarom/viewmodel/theme.dart';
import 'package:ZnoNeZaBarom/model/counter/znoCountersSave.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import '../../view/addSubject/addSubjectCounter.dart';
import '../../view/main/main.dart';

class CounterManager {
  static List<ZnoCounter> counters = [];
  static Map<Subject, Duration> timeLeft = Map();
  static ThemeSelector _themeSelector;
  static bool countersInit = false;

  static void init() {
    _themeSelector = ThemeSelector();
    var firstSubjectTime = DateTime(2021, 5, 21, 9);
    add(ZnoCounter(Subject.firstOne, firstSubjectTime));
    CounterManager.timeLeft[Subject.firstOne] =
        CounterManager.counters[0].znoTimeDifference();

  }

  static void lateInit(BuildContext context, State state) async {
    var potentialCounters = await ZnoCountersSave.init();
    for (var i in potentialCounters) {
      SubjectManager.add(context, i);
    }
    countersInit = true;
    for (var counter in CounterManager.counters) {
      CounterManager.timeLeft[counter.subject] = counter.znoTimeDifference();
    }
    state.setState(() {});
  }

  static add(ZnoCounter counter) {
    CounterManager.counters.add(counter);
    SubjectManager.subjectsShown.add(counter.subject);
  }

  static remove(ZnoCounter counter) {
    CounterManager.counters.remove(counter);
    SubjectManager.subjectsShown.remove(counter.subject);
  }

  static start(DynamicState view, BuildContext context) async {
    while (true) {
      for (var counter in counters) {
        timeLeft[counter.subject] = counter.znoTimeDifference();
      }
      // CHANGING THEME IF HAS TO
      await new Future.delayed(const Duration(seconds: 1));
      if (view.mounted) {
        ThemeSelector.isDark = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
        var data = _themeSelector.select(context);
        DynamicTheme.of(context).setThemeData(data);
      }
    }
  }
}
