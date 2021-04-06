import 'package:ZnoNeZaBarom/model/subjects/subjects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import '../../model/counter/counters.dart';
import '../../model/counter/durationTime.dart';
import '../../viewmodel/languageManager.dart';
import 'main.dart';

class MainCounterView extends StatefulWidget {
  @override
  _MainCounterViewState createState() => _MainCounterViewState();
}

class _MainCounterViewState extends State<MainCounterView> {
  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    initRiveAnimations();
  }

  @override
  Widget build(BuildContext context) {
    var decoration = _buildDecoration();
    var title = _buildTitle();
    var counterText = _buildCounterText();
    var riveAnimation = _buildRiveAnimation();
    return Container(
      decoration: decoration,
      child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              title,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  counterText,
                  _riveArtboard == null
                      ? const SizedBox()
                      : riveAnimation
                ],
              )
            ],
          )),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15)),
      color: Theme
          .of(context)
          .accentColor,
    );
  }

  _buildTitle() {
    return Center(
        child: Text(
            LocalizationTool
                .of(context)
                .znoTimeLeftTitle,
            style:
            Theme
                .of(context)
                .textTheme
                .headline4));
  }

  _buildCounterText() {
    return Text(
        DurationTimeConverter.shortTimeString(
            CounterManager.timeLeft[Subject.firstOne], context),
        style: Theme
            .of(context)
            .textTheme
            .headline3);
  }

  _buildRiveAnimation() {
    return Container(
        width: 60,
        height: 100,
        child: Rive(artboard: _riveArtboard));
  }

  void initRiveAnimations() {
    rootBundle.load("assets/pencil.riv").then((data) async {
      final file = RiveFile();
      if (file.import(data)) {
        final artboard = file.mainArtboard;
        artboard.artboard.addController(_controller = SimpleAnimation("go"));
        setState(() => _riveArtboard = artboard);
      }
    });
  }
}


class SmallCountersView extends StatefulWidget {
  SmallCountersView({Key key}) : super(key: key);

  @override
  _SmallCountersViewState createState() => _SmallCountersViewState();
}

class _SmallCountersViewState extends State<SmallCountersView> {
  @override
  Widget build(BuildContext context) {
    var emptyListWidget = _buildEmptySubjectList();
    var smallCounters = _buildSmallCounters();
    var circularIndicator = _buildCircularProgressIndicator();
    return CounterManager.countersInit
                        ? CounterManager.counters.length > 1
                        ? smallCounters
                        : emptyListWidget
                        : circularIndicator;
    
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
  Widget _buildSmallCounters(){
    return Expanded(
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: CounterManager.counters.length,
                                itemBuilder: (context, i) {
                                  if (i != 0) {
                                    return SubjectTimerView(
                                        CounterManager.counters[i].subject);
                                  } else
                                    return Container(); // we don't need to have "firstSubject" timer
                                  // because we've got it in the center of the screen
                                })));
  }
  Widget _buildCircularProgressIndicator(){
    return CircularProgressIndicator();
  }
}