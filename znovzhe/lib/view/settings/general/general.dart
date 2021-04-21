import 'package:ZnoNeZaHoramy/view/settings/general/generalSettings.dart';
import 'package:ZnoNeZaHoramy/viewmodel/languageManager.dart';
import 'package:ZnoNeZaHoramy/viewmodel/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralSettingsView extends StatefulWidget {
  GeneralSettingsView({Key key}) : super(key: key);

  @override
  _GeneralSettingsViewState createState() => _GeneralSettingsViewState();
}

class _GeneralSettingsViewState extends State<GeneralSettingsView> {
  @override
  Widget build(BuildContext context) {
    var appBar = _buildAppBar();
    var darkMode = DarkModeSettingView();
    return Scaffold(
        appBar: appBar,
        body: Padding(
            padding: EdgeInsets.all(25),
            child: ListView(
              children: [
                Card(child: darkMode),
              ],
            )));
  }

  _buildAppBar() {
    return AppBar(
      backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Theme.of(context).accentColor),
      iconTheme: IconThemeData(color: ThemeSelector.getForegroundColor()),
      actionsIconTheme: IconThemeData(color: ThemeSelector.getForegroundColor()),
      title: Text(
        LocalizationTool.of(context).general,
        style: Theme.of(context).textTheme.headline6,
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }
}
