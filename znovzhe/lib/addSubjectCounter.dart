import 'package:flutter/material.dart';
import 'package:znovzhe/subjectIcons.dart';
import 'package:znovzhe/znoCountersSave.dart';

import 'languageManager.dart';
import 'main.dart';

class AddSubjectWidget extends StatefulWidget {
  final List<Subject> subjectsAlreadyShown;
  AddSubjectWidget(this.subjectsAlreadyShown, {Key key}) : super(key: key);

  @override
  _AddSubjectWidgetState createState() =>
      _AddSubjectWidgetState(subjectsAlreadyShown);
}

class _AddSubjectWidgetState extends State<AddSubjectWidget> {
  List<Subject> subjectsShown;
  _AddSubjectWidgetState(this.subjectsShown);
  Map<Subject, bool> subjectsAvailable =
      Map(); // bool means if this kind of counter is already on the main screen
  ScrollController _controller;
  @override
  void initState() {
    for (var v in subjectsShown) {
      subjectsAvailable[v] = true;
    }
    _controller = ScrollController();
    _controller.addListener(_scrollListener); //the listener for up and down.
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: ListView.builder(
              controller: _controller,
              itemCount: Subject.values.length - 1,
              itemBuilder: (context, i) {
                var vals = Subject.values.toList();
                vals.remove(Subject.firstOne);
                var sub = vals[i];
                var subjAv = subjectsAvailable[sub];
                var subAv = (subjAv == null) ? false : subjAv;
                return subjectAddItem(sub, subAv);
              })),
    ]));
  }

  Widget subjectAddItem(Subject subject, bool isAlreadyChosen) {
    var subjectName = SubjectValues.getSubjectName(context, subject);
    var tile = Card(
        child: ListTile(
          leading: SubjectValues.getIcon(context, subject),
            title: Text(
              subjectName,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: IconButton(
              onPressed: isAlreadyChosen
                  ? () => removeFromMain(subject)
                  : () => addToMain(subject),
              icon: isAlreadyChosen ? Icon(Icons.remove) : Icon(Icons.add),
            )));
    return tile;
  }

  addToMain(Subject subject) {
    SubjectManager.add(context, subject);
    subjectsAvailable[subject] = true;
    setState(() {});
  }

  removeFromMain(Subject subject) {
    SubjectManager.remove(context, subject);
    subjectsAvailable[subject] = false;
    setState(() {});
  }
}

class SubjectManager {
  static add(BuildContext context, Subject subject) {
    var v = MyHomePageState.counters.where((x) => x.subject == subject);
    if (v.length == 0) {
      var znoTime = SubjectValues.getZNODateTime(context, subject);
      var newCounter = ZnoCounter(subject, znoTime);
      MyHomePageState.counters.add(newCounter);
      ZnoCountersSave.save();
    }
  }

  static remove(BuildContext context, Subject subject) {
    var v =
        MyHomePageState.counters.where((x) => x.subject == subject).toList();
    if (v.length != 0) {
      MyHomePageState.counters.remove(v[0]);
      ZnoCountersSave.save();
    }
  }
}
