import 'package:ZnoNeZaBarom/model/settings/general/generalModel.dart';
import 'package:ZnoNeZaBarom/model/settings/settingsManager.dart';
import 'package:ZnoNeZaBarom/view/settings/settings.dart';
import 'package:ZnoNeZaBarom/viewmodel/languageManager.dart';
import 'package:flutter/material.dart';
class DarkModeSettingView extends StatefulWidget {
  DarkModeSettingView({Key key}) : super(key: key);

  @override
  _DarkModeSettingState createState() => _DarkModeSettingState();
}

class _DarkModeSettingState extends SettingViewState<DarkModeSettingView> {
  bool isDark = false;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var switchWidget =  _buildSwitch();
    return ListTile(trailing: switchWidget, leading: Text(LocalizationTool.of(context).darkModeSetting, style: Theme.of(context).textTheme.bodyText2,));
  }
  Widget _buildSwitch(){
    return Switch(onChanged: (b)=> change(SettingValue<bool>(b)), value: isDark);
  }
  @override
  void change(SettingValue value) async{
    super.change(value);
    var setting = SettingsManager.getSetting(DarkModeSetting);
    setting[0].changeSetting(value, context);
    
  }
}