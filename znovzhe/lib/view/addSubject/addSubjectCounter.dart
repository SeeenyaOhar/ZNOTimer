import 'package:ZnoNeZaBarom/model/subjects/subjectManager.dart';
import 'package:ZnoNeZaBarom/model/subjects/subjects.dart';
import 'package:ZnoNeZaBarom/viewmodel/theme.dart';
import 'package:flutter/material.dart';
import 'package:ZnoNeZaBarom/viewmodel/subjectIcons.dart';
import 'package:ZnoNeZaBarom/model/counter/znoCountersSave.dart';

import '../../model/counter/counters.dart';
import '../../viewmodel/languageManager.dart';
import '../main/main.dart';
import 'addSubjectCounterComponents.dart';
class AddSubjectWidget extends StatefulWidget {
  final List<Subject> subjectsAlreadyShown;
  AddSubjectWidget(this.subjectsAlreadyShown, {Key key}) : super(key: key);

  @override
  _AddSubjectWidgetState createState() =>
      _AddSubjectWidgetState(subjectsAlreadyShown);
}

class _AddSubjectWidgetState extends State<AddSubjectWidget> {

  _AddSubjectWidgetState(List subjectsShown){

  }

  DefaultInterstitialHandler handler;
  @override
  void initState() {
    
    initAd();
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
        body: Column(children: [
      Expanded(
          child: addSubjectsList),
    ]));
  }

  
}

