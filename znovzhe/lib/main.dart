import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:znovzhe/addSubjectCounter.dart';
import 'package:znovzhe/languageManager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:znovzhe/znoCountersSave.dart';
import 'dart:io';
import 'dart:math';

import 'subjectIcons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const ZnoVzheLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale.fromSubtags(languageCode: "ru"),
        const Locale("ua", "UA")
      ],
      title: 'ZNO Vzhe',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lime,

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Zno Vzhe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static List<ZnoCounter> counters = List<ZnoCounter>();
  static Map<Subject, Duration> timeLeft = Map();

  bool _countersInit = false;

  @override
  void initState() {
    var firstSubjectTime = DateTime(2021, 5, 21, 9);
    counters.add(ZnoCounter(Subject.firstOne, firstSubjectTime));
    timeLeft[Subject.firstOne] = counters[0].znoTimeDifference();
    lateInit();
    count();
    super.initState();
  }

  void count() async {
    while (true) {
      for (var counter in counters) {
        timeLeft[counter.subject] = counter.znoTimeDifference();
      }
      setState(() {});
      await new Future.delayed(const Duration(seconds: 1));
    }
  }

  Widget _buildAddNewSubjectFloatingButton() {
    List<Subject> subjectsAlreadyOnScreen = List();
    for (var counter in counters) {
      subjectsAlreadyOnScreen.add(counter.subject);
    }

    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddSubjectWidget(subjectsAlreadyOnScreen))),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var newSubjectFloatingButton = _buildAddNewSubjectFloatingButton();
    return Scaffold(
        floatingActionButton: newSubjectFloatingButton,
        body: Center(
            child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Center(
                              child: Text(
                                  LocalizationTool.of(context).znoTimeLeftTitle,
                                  style:
                                      Theme.of(context).textTheme.headline4)),
                          Text(
                              DurationTimeConverter.shortTimeString(
                                  timeLeft[Subject.firstOne], context),
                              style: Theme.of(context).textTheme.headline3),
                        ]))),
                
                _countersInit
                    ? Expanded(
                        child: Padding(padding: EdgeInsets.all(20), child: ListView.builder(
                            itemCount: counters.length,
                            itemBuilder: (context, i) {
                              if (i != 0) {
                                return SubjectTimer(counters[i].subject);
                              } else
                                return Container(); // we don't need to have "firstSubject" timer
                              // because we've got it in the center of the screen
                            })))
                    : CircularProgressIndicator()
              ],
            ),
          ),
        )));
    // floatingActionButton: newSubjectFloatingButton);
  }

  Future<void> lateInit() async {
    var potentialCounters = await ZnoCountersSave.init();
    for (var i in potentialCounters) {
      SubjectManager.add(context, i);
    }
    _countersInit = true;
    for (var counter in counters) {
      timeLeft[counter.subject] = counter.znoTimeDifference();
    }
    setState(() {});
  }
}

class DurationTimeConverter {
  static String shortTimeString(Duration time, BuildContext context) {
    var buffer = new StringBuffer();
    var monthsLeft = time.inDays / 30;
    var days = ((monthsLeft - monthsLeft.floor()) * 30);
    bool monthsWritten = true;
    if (monthsLeft != 0) {
      var monthsString = "";
      var lastNumberMonth = monthsLeft % 10;
      if (lastNumberMonth == 1) {
        monthsString = LocalizationTool.of(context).months1;
      } else if (lastNumberMonth < 5) {
        monthsString = LocalizationTool.of(context).months234;
      } else {
        monthsString = LocalizationTool.of(context).months5;
      }

      buffer.write("${monthsLeft.floor()} $monthsString");
    }
    if (days != 0) {
      var daysString = "";
      var lastNumberDay = days % 10;
      if (days > 10 && days < 20) {
        daysString = LocalizationTool.of(context).days5;
      } else {
        if (lastNumberDay == 1) {
          daysString = LocalizationTool.of(context).days1;
        } else if (lastNumberDay < 5) {
          daysString = LocalizationTool.of(context).days234;
        } else {
          daysString = LocalizationTool.of(context).days5;
        }
      }
      if (monthsWritten){
        buffer.write(",\n${days.floor()} $daysString");
      }
      else{
        buffer.write("${days.floor()} $daysString");
      }
      
    }
    return buffer.toString();
  }
}

class SubjectTimer extends StatefulWidget {
  final Subject _subject;
  SubjectTimer(this._subject, {Key key}) : super(key: key);

  @override
  _SubjectTimerState createState() => _SubjectTimerState(this._subject);
}

class _SubjectTimerState extends State<SubjectTimer> {
  Subject _subject;
  _SubjectTimerState(this._subject);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: SubjectValues.getIcon(context, _subject),
        title: Text(SubjectValues.getSubjectName(context, _subject)),
        trailing: Text(DurationTimeConverter.shortTimeString(
            MyHomePageState.timeLeft[_subject], context)));
  }
}

class ZnoCounter {
  Subject subject;
  final DateTime znoTime;

  ZnoCounter(this.subject, this.znoTime);

  Duration znoTimeDifference() {
    var timeNow = DateTime.now();
    return znoTime.difference(timeNow);
  }
}

enum Subject {
  english,
  ukrainianLanguageLiterature,
  math,
  biology,
  history,
  physics,
  germanLanguage,
  spanishLanguage,
  geography,
  chemistry,
  frenchLanguage,
  firstOne
}
