import 'package:ZnoNeZaHoramy/model/settings/general/generalModel.dart';
import 'package:ZnoNeZaHoramy/model/settings/settingsManager.dart';
import 'package:ZnoNeZaHoramy/view/settings/settings.dart';
import 'package:ZnoNeZaHoramy/viewmodel/languageManager.dart';
import 'package:ZnoNeZaHoramy/viewmodel/theme.dart';
import 'package:flutter/material.dart';

class DarkModeSettingView extends StatefulWidget {
  DarkModeSettingView({Key key}) : super(key: key);

  @override
  _DarkModeSettingState createState() => _DarkModeSettingState();
}

class _DarkModeSettingState extends SettingViewState<DarkModeSettingView, DarkMode> {
  DarkMode isDark = DarkMode.system;

  @override
  void initState() {
    super.initState();
    isDark = SettingsManager.getSetting<DarkModeSetting>().first.getSettingValue(context);
  }

  @override
  Widget build(BuildContext context) {
    var switchWidget = _buildDropdown();
    return ListTile(
        trailing: switchWidget,
        leading: Icon(Icons.style, color: Theme.of(context).accentColor),
        title: Text(
          LocalizationTool.of(context).darkModeSetting,
          style: Theme.of(context).textTheme.bodyText2,
        ),tileColor: ThemeSelector.isDark ? Colors.black54 : Colors.white,);
  }

  Widget _buildDropdown() {
    return DropdownButton(
      items: [
        DropdownMenuItem(
            child: Text(LocalizationTool.of(context).darkModeSystem),
            onTap: () => change(SettingValue(DarkMode.system)),
            value: DarkMode.system),
        DropdownMenuItem(
            child: Text(LocalizationTool.of(context).darkModeDark),
            onTap: () => change(SettingValue(DarkMode.dark)),
            value: DarkMode.dark),
        DropdownMenuItem(
            child: Text(LocalizationTool.of(context).darkModeLight),
            onTap: () => change(SettingValue(DarkMode.light)),
            value: DarkMode.light),
      ],
      value: isDark,
      onChanged: (val) {
        change(SettingValue(val));
        isDark = val;
        setState(() {});
      },
    );
  }

  @override
  void change(SettingValue<DarkMode> value) {
    assert(value.getValue().runtimeType == DarkMode);
    isDark = value.getValue();
    var setting = SettingsManager.getSetting<DarkModeSetting>();
    setting.first.changeSetting(value, context);


    setState(() {});
    super.change(value);
  }


}

enum DarkMode { system, dark, light }
