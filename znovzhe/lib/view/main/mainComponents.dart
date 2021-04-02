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
