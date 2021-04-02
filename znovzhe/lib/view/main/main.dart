import 'package:ZnoNeZaBarom/view/settings/settings.dart';
import 'package:ZnoNeZaBarom/viewmodel/theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rive/rive.dart';
import 'package:ZnoNeZaBarom/view/addSubject/addSubjectCounter.dart';
import 'package:ZnoNeZaBarom/model/counter/ads.dart';
import 'package:ZnoNeZaBarom/viewmodel/languageManager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ZnoNeZaBarom/model/counter/znoCountersSave.dart';
import 'dart:io';
import 'dart:math';
import '../../model/counter/counters.dart';
import '../../model/counter/durationTime.dart';
import 'mainComponents.dart';
import '../../viewmodel/subjectIcons.dart';
import "package:dynamic_theme/dynamic_theme.dart";

void main() {
  // I HAVE TO MENTION HERE THAT THE VIEWMODEL SYSTEM IS HERE IS FAR FROM THE REAL VERSION
  // WHAT I CALL MODEL AND VIEWMODEL MEANS LOGIC AND LOGIC THAT OPERATES THE VIEW WHICH IS A BIT DIFFERENT FROM WHAT IT REALLY IS
  // I DIDN'T WANT TO MAKE IT REAL BECAUSE I DIDN'T KNOW HOW TO IMPLEMENT IT IN DART, THUS I OMITTED IT
  WidgetsFlutterBinding.ensureInitialized();
  AdmobHelper.initFirebaseAdmob();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (brightness) =>
      WidgetsBinding.instance.window.platformBrightness == Brightness.dark ? ThemeData(
          primarySwatch: Colors.lightGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: ThemeSelector.BACKGROUND_DARK,
          scaffoldBackgroundColor: ThemeSelector.BACKGROUND_DARK,
          textTheme: TextTheme(
              bodyText2: TextStyle(color: ThemeSelector.TEXT_COLOR_DARK),
              bodyText1: TextStyle(color: ThemeSelector.TEXT_COLOR_DARK),
              headline1: TextStyle(color: ThemeSelector.TEXT_COLOR_DARK),
              headline3: TextStyle(color: ThemeSelector.TEXT_COLOR_DARK),
              headline2: TextStyle(color: ThemeSelector.TEXT_COLOR_DARK),
              headline4: TextStyle(color: ThemeSelector.TEXT_COLOR_DARK),
              headline6: TextStyle(color: ThemeSelector.TEXT_COLOR_DARK),
              headline5: TextStyle(color: ThemeSelector.TEXT_COLOR_DARK))
      ) : ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: ThemeSelector.BACKGROUND_WHITE,
        scaffoldBackgroundColor: ThemeSelector.BACKGROUND_WHITE,
        textTheme: TextTheme(
            bodyText2: TextStyle(color: ThemeSelector.TEXT_COLOR_WHITE),
            bodyText1: TextStyle(color: ThemeSelector.TEXT_COLOR_WHITE),
            headline1: TextStyle(color: ThemeSelector.TEXT_COLOR_WHITE),
            headline3: TextStyle(color: ThemeSelector.TEXT_COLOR_WHITE),
            headline2: TextStyle(color: ThemeSelector.TEXT_COLOR_WHITE),
            headline4: TextStyle(color: ThemeSelector.TEXT_COLOR_WHITE),
            headline6: TextStyle(color: ThemeSelector.TEXT_COLOR_WHITE),
            headline5: TextStyle(color: ThemeSelector.TEXT_COLOR_WHITE)),
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          localizationsDelegates: [
            const ZnoVzheLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,

          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale.fromSubtags(languageCode: "ru"),
            const Locale("ua", "UA"),
            const Locale.fromSubtags(languageCode: "uk")
          ],
          home: MyHomePage(title: 'Zno Ne Za Goramy'),
          title: 'ZNO Vzhe',
          theme: theme,
        );
      },
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

class MyHomePageState extends DynamicState<MyHomePage> {
  ThemeSelector selector = ThemeSelector();
  DefaultInterstitialHandler handler;
  bool isDark = true;

  @override
  void initState() {
    CounterManager.init();
    CounterManager.start(this, context);
    CounterManager.lateInit(context, this);
    super.initState();
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
    var emptyListWidget = _buildEmptySubjectList();
    var appbarWidget = _buildAppBar();
    var body =
    _buildBody(newSubjectFloatingButton, emptyListWidget, appbarWidget);
    var gestureDetector = _buildGestureDetector(body);
    var finalPage = gestureDetector;
    return finalPage;
    // floatingActionButton: newSubjectFloatingButton);
  }
  Widget _buildAddNewSubjectFloatingButton() {
    List<Subject> subjectsAlreadyOnScreen = [];
    for (var counter in CounterManager.counters) {
      subjectsAlreadyOnScreen.add(counter.subject);
    }
    return FloatingActionButton(
      onPressed: () =>
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddSubjectWidget(subjectsAlreadyOnScreen))),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }

  Widget _buildEmptySubjectList() {
    return Expanded(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  LocalizationTool
                      .of(context)
                      .emptyListRecommendation,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(30),
                  child: Icon(Icons.arrow_downward,
                      size: 32,
                      color: Theme
                          .of(context)
                          .textTheme
                          .bodyText2
                          .color)),
            ]));
  }

  Widget _buildAppBar() {
    return AppBar(
        title: Center(
            child: Text(LocalizationTool
                .of(context)
                .appName
                .toUpperCase())),
        titleTextStyle: Theme
            .of(context)
            .textTheme
            .headline6,
        backgroundColor: Theme
            .of(context)
            .accentColor,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme
                .of(context)
                .accentColor),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsPage(),));
          },),
        ]
    );
  }

  _buildBody(Widget newSubjectFloatingButton, Widget emptyListWidget,
      Widget appbarWidget) {
    var mainCounter = _buildMainCounter();
    return Scaffold(
        appBar: appbarWidget,
        floatingActionButton: newSubjectFloatingButton,
        body: Center(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    mainCounter,
                    CounterManager.countersInit
                        ? CounterManager.counters.length > 1
                        ? Expanded(
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: CounterManager.counters.length,
                                itemBuilder: (context, i) {
                                  if (i != 0) {
                                    return SubjectTimer(
                                        CounterManager.counters[i].subject);
                                  } else
                                    return Container(); // we don't need to have "firstSubject" timer
                                  // because we've got it in the center of the screen
                                })))
                        : emptyListWidget
                        : CircularProgressIndicator()
                  ],
                ),
              ),
            )));
  }

  _buildGestureDetector(body) {
    return GestureDetector(
        onPanUpdate: (a) {
          if (a.delta.dy < -7) {
            List<Subject> subjectsAlreadyOnScreen = List();
            for (var counter in CounterManager.counters) {
              subjectsAlreadyOnScreen.add(counter.subject);
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddSubjectWidget(subjectsAlreadyOnScreen)));
          }
        },
        child: body);
  }

  _buildMainCounter() {
    return MainCounterView();
  }
}


class DefaultInterstitialHandler {
  InterstitialAd interstitial;

  void initAd() {
    var listener = (Ad ad) {
      print("Ad loaded!");
      interstitial.show();
    };
    interstitial =
        AdmobHelper.createInterstitial(DefaultInterstitialListener(listener));
  }

  void load() {
    interstitial.load();
  }
}

class DefaultInterstitialListener extends AdListener {
  Function(Ad ad) onAdLoadedFun;
  static final Function(Ad ad) onAdLoadedDefault =
      (Ad ad) => print("Ad loaded");

  DefaultInterstitialListener(Function(Ad ad) onAdLoaded) {
    onAdLoadedFun = onAdLoaded;
  }

  @override
  void Function(Ad ad) get onAdClosed =>
          (Ad ad) {
        ad.dispose();
        print("Ad closed");
      };

  @override
  void Function(Ad ad, LoadAdError error) get onAdFailedToLoad =>
          (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Ad failed to load: $error');
      };

  @override
  void Function(Ad ad) get onAdLoaded => (Ad ad) => onAdLoadedFun(ad);

  @override
  void Function(Ad ad) get onAdOpened => (Ad ad) => print('Ad opened.');

  @override
  void Function(Ad ad) get onApplicationExit =>
          (Ad ad) => print('Left application.');
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
    return Column(children: <Widget>[
      Divider(),
      ListTile(
          leading: SubjectValues.getIcon(context, _subject),
          title: Text(SubjectValues.getSubjectName(context, _subject),
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2),
          trailing: Text(
              DurationTimeConverter.shortTimeString(
                  CounterManager.timeLeft[_subject], context),
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2))
    ]);
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
