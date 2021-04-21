import 'package:ZnoNeZaHoramy/model/settings/settingsManager.dart';
import 'package:ZnoNeZaHoramy/view/settings/general/general.dart';
import 'package:ZnoNeZaHoramy/viewmodel/languageManager.dart';
import 'package:ZnoNeZaHoramy/viewmodel/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingViewState<T extends StatefulWidget, T1> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void change(SettingValue<T1> value) {}
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    SettingsManager.initializeSettings(context);
  }

  @override
  Widget build(BuildContext context) {
    var appBar = _buildAppBar();
    return Scaffold(
      appBar: appBar,
        body: Padding(padding: EdgeInsets.all(25), child: ListView(
      children: [
        _buildListTile(context, LocalizationTool.of(context).general, GeneralSettingsView(), Icon(Icons.settings)),
      ],
    )));
  }
  AppBar _buildAppBar() {
    return AppBar(
      backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Theme.of(context).accentColor),
      iconTheme: IconThemeData(color: ThemeSelector.getForegroundColor()),
      actionsIconTheme: IconThemeData(color: ThemeSelector.getForegroundColor()),
      title: Text(LocalizationTool.of(context).settings, style: Theme.of(context).textTheme.headline6),
      backgroundColor: Theme.of(context).accentColor,
    );
  }
  _buildListTile(BuildContext context,String title, StatefulWidget settingsPage, Icon icon){
    return Card(child: ListTile(
      leading: icon,
      title: Text(title, style: Theme.of(context).textTheme.bodyText2),
      onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => settingsPage)),
      tileColor: ThemeSelector.isDark ? Colors.black54 : Colors.white,
    ));
  }


}
