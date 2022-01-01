import 'package:ZnoNeZaHoramy/model/counter/counters.dart';
import 'package:ZnoNeZaHoramy/model/subjects/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZnoCountersSave {
  static final String saveKey = "subs";
  static save() async {
    var state = SortCounterManager().counters.toList();
    state.remove(state
        .where((x) => x.subject == Subject.firstOne)
        .toList()[0]); // removing the first one
    List<Subject> subjects = List();
    for (var i in state) {
      subjects.add(i.subject);
    }
    StringBuffer sharedPref = StringBuffer();
    for (var i in subjects) {
      int i2 = i.index;
      sharedPref.write(i2.toString() + ";");
    }

    var sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(saveKey, sharedPref.toString());
  }

  static Future<List<Subject>> init() async {
    List<Subject> subjects = [];
    var sharedPrefs = await SharedPreferences.getInstance();

    var subsStr = sharedPrefs.getString(saveKey);
    if (subsStr != null) {
      var splitSubsStr = subsStr.split(';');
      for (var v in splitSubsStr) {
        if (v != "") {
          int i = int.parse(v);
          subjects.add(Subject.values[i]);
        }
      }
    }

    return subjects;
  }
}
