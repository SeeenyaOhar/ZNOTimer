import 'package:ZnoNeZaHoramy/model/ads/ads.dart';
import 'package:ZnoNeZaHoramy/model/subjects/subjectManager.dart';
import 'package:ZnoNeZaHoramy/model/subjects/subjects.dart';
import 'package:ZnoNeZaHoramy/viewmodel/theme.dart';
import 'package:flutter/material.dart';
import 'package:ZnoNeZaHoramy/viewmodel/subjectIcons.dart';
import 'package:ZnoNeZaHoramy/model/counter/znoCountersSave.dart';
import 'package:flutter/services.dart';

import '../../model/counter/counters.dart';
import '../../viewmodel/languageManager.dart';
import '../main/main.dart';
import 'addSubjectCounterComponents.dart';

class AddSubjectWidget extends StatefulWidget {
  AddSubjectWidget({Key key}) : super(key: key);

  @override
  _AddSubjectWidgetState createState() =>
      _AddSubjectWidgetState();
}

class _AddSubjectWidgetState extends State<AddSubjectWidget> {
  DefaultInterstitialHandler handler;
  @override
  void initState() {
    //initAd();
    super.initState();
  }

  void initAd() {
    handler = DefaultInterstitialHandler();
    handler.initAd();
    handler.load();
  }

  @override
  Widget build(BuildContext context) {
    var addSubjectsList = AddSubjectsList();
    return Scaffold(
        appBar: _buildAppBar(),
        body: Column(children: [
          Expanded(child: addSubjectsList),
        ]));
  }

  _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: ThemeSelector.getForegroundColor()),
      title: Text(LocalizationTool.of(context).addSubjectAppBarTitle,
          style: Theme.of(context).textTheme.headline6),
      backgroundColor: Theme.of(context).accentColor,
      backwardsCompatibility: false,
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: Theme.of(context).accentColor),
    );
  }
}
