import 'package:ZnoNeZaHoramy/model/subjects/subjectManager.dart';
import 'package:ZnoNeZaHoramy/model/subjects/subjects.dart';
import 'package:ZnoNeZaHoramy/viewmodel/subjectIcons.dart';
import 'package:ZnoNeZaHoramy/viewmodel/theme.dart';
import 'package:flutter/material.dart';

class AddSubjectsList extends StatefulWidget {
  AddSubjectsList({Key key}) : super(key: key);

  @override
  _AddSubjectsListState createState() => _AddSubjectsListState();
}

class _AddSubjectsListState extends State<AddSubjectsList> {
  final ScrollController _controller = ScrollController();
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
  void initState() {
    super.initState();
    for (var v in SubjectManager.subjectsShown) {
      SubjectManager.subjectsAvailable[v] = true;
    }
    _controller.addListener(_scrollListener); //the listener for up and down.
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _controller,
        itemCount: Subject.values.length - 1,
        itemBuilder: (context, i) {
          var vals = Subject.values.toList();
          vals.remove(Subject.firstOne);
          var sub = vals[i];
          var subjAv = SubjectManager.subjectsAvailable[sub];
          var subAv = (subjAv == null) ? false : subjAv;
          return subjectAddItem(sub, subAv);
        });
  }

  Widget subjectAddItem(Subject subject, bool isAlreadyChosen) {
    var subjectName = SubjectValues.getSubjectName(context, subject);
    var tile = Card(
        child: ListTile(
            tileColor: ThemeSelector.isDark ? Colors.black87 : Colors.white,
            leading: SubjectValues.getIcon(context, subject),
            title: Text(
              subjectName,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: IconButton(
              onPressed: isAlreadyChosen
                  ? () => removeFromMain(subject)
                  : () => addToMain(subject),
              icon: isAlreadyChosen
                  ? Icon(Icons.remove,
                      color: Theme.of(context).textTheme.bodyText2.color)
                  : Icon(Icons.add,
                      color: Theme.of(context).textTheme.bodyText2.color),
            )));
    return tile;
  }

  addToMain(Subject subject) async {
    await SubjectManager.add(context, subject);
    SubjectManager.subjectsAvailable[subject] = true;
    setState(() {});
  }

  removeFromMain(Subject subject) {
    SubjectManager.subjectsAvailable[subject] = false;
    SubjectManager.remove(context, subject);
    setState(() {});
  }
}
