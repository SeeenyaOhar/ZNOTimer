import 'package:ZnoNeZaHoramy/model/subjects/subjectManager.dart';
import 'package:ZnoNeZaHoramy/model/subjects/subjects.dart';
import 'package:ZnoNeZaHoramy/viewmodel/theme.dart';
import 'package:ZnoNeZaHoramy/viewmodel/theme.dart';
import 'package:ZnoNeZaHoramy/model/counter/znoCountersSave.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import '../../view/addSubject/addSubjectCounter.dart';
import '../../view/main/main.dart';

class CounterManager {
  CounterManager._();
  List<ZnoCounter> counters = [];
  Map<Subject, Duration> timeLeft = Map();
  bool areCountersInit = false;
  static final CounterManager _manager = CounterManager._internal();
  factory CounterManager() {
    return _manager;
  }
  CounterManager._internal();
// Initializes the fields
  void init() {}
// Late initalization for the fields(used for the async await methods)
  void lateInit(BuildContext context, State state) {}
// starts the counters
  start(DynamicState view, BuildContext context) async {}
// ads a new counter
  add(ZnoCounter counter) {}
// removes a counter
  remove(ZnoCounter counter) {}
}

class SimpleCounterManager extends CounterManager {
   static final SimpleCounterManager _manager = SimpleCounterManager._internal();
   factory SimpleCounterManager() {
    return _manager;
  }
  SimpleCounterManager._internal() : super._internal();

  ThemeSelector _themeSelector;
  
  

  @override
  void init() {
    _themeSelector = ThemeSelector();
    var firstSubjectTime = DateTime(2021, 5, 21, 9);
    add(ZnoCounter(Subject.firstOne, firstSubjectTime));
    timeLeft[Subject.firstOne] = counters[0].znoTimeDifference();
  }

  @override
  void lateInit(BuildContext context, State state) async {
    var potentialCounters = await ZnoCountersSave.init();
    for (var i in potentialCounters) {
      SubjectManager.add(context, i);
    }
    areCountersInit = true;
    for (var counter in counters) {
      timeLeft[counter.subject] = counter.znoTimeDifference();
    }
    state.setState(() {});
  }

  @override
  add(ZnoCounter counter) {
    counters.add(counter);
    SubjectManager.subjectsShown.add(counter.subject);
  }

  @override
  remove(ZnoCounter counter) {
    counters.remove(counter);
    SubjectManager.subjectsShown.remove(counter.subject);
  }

  @override
  start(DynamicState view, BuildContext context) async {
    while (true) {
      for (var counter in counters) {
        timeLeft[counter.subject] = counter.znoTimeDifference();
      }
      // CHANGING THEME IF HAS TO
      await new Future.delayed(const Duration(seconds: 1));
      if (view.mounted) {
        ThemeSelector.isDark =
            WidgetsBinding.instance.window.platformBrightness ==
                Brightness.dark;
        var data = _themeSelector.select(context);
        DynamicTheme.of(context).setThemeData(data);
      }
    }
  }
}

class SortCounterManager extends CounterManager{
  static final _manager = SortCounterManager._internal();
  factory SortCounterManager(){
    return _manager;
  }
  SortCounterManager._internal() : super._internal();


   ThemeSelector _themeSelector;
  @override
  void init() {
    _themeSelector = ThemeSelector();
    var firstSubjectTime = DateTime(2021, 5, 21, 9);
    add(ZnoCounter(Subject.firstOne, firstSubjectTime));
    timeLeft[Subject.firstOne] = counters[0].znoTimeDifference();
  }
// Late initalization for the fields(used for the async await methods)
@override
  void lateInit(BuildContext context, State state) async{
    var potentialCounters = await ZnoCountersSave.init();
    for (var i in potentialCounters) {
      SubjectManager.add(context, i);
    }
    areCountersInit = true;
    for (var counter in counters) {
      timeLeft[counter.subject] = counter.znoTimeDifference();
    }
    state.setState(() {});
  }
// starts the counters
  @override
  start(DynamicState view, BuildContext context) async {
    while (true) {
      for (var counter in counters) {
        timeLeft[counter.subject] = counter.znoTimeDifference();
      }
      // CHANGING THEME IF HAS TO
      await new Future.delayed(const Duration(seconds: 1));
      if (view.mounted) {
        ThemeSelector.isDark =
            WidgetsBinding.instance.window.platformBrightness ==
                Brightness.dark;
        var data = _themeSelector.select(context);
        DynamicTheme.of(context).setThemeData(data);
      }
    }
  }
// ads a new counter
  @override
  add(ZnoCounter counter) {
    int i = 0;
    counters.forEach((x)=>{
      // zero is reserved for "Subjects.firstOne"
      if (counter.subject != Subject.firstOne && x.znoTimeDifference().compareTo(counter.znoTimeDifference()) < 0 ){
        i++  
      }
    });
    counters.insert(i,counter);
    SubjectManager.subjectsShown.add(counter.subject);
  }
// removes a counter
  @override
  remove(ZnoCounter counter) {
    counters.remove(counter);
    SubjectManager.subjectsShown.remove(counter.subject);
  }
}