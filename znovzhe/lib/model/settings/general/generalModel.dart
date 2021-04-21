import 'package:ZnoNeZaHoramy/model/settings/settingsManager.dart';
import 'package:ZnoNeZaHoramy/view/settings/general/generalSettings.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeSetting implements Setting<DarkMode>{
  // this approach is kinda unprofessional but i just leave it here
  // i should have moved an interface for setting shared prefrences to another 
  final String _key = "DARK_MODE";
  DarkMode _isDark;
  @override
  void changeSetting(SettingValue<DarkMode> val, BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    _isDark = val.getValue();
    await prefs.setInt(_key, _isDark.index);
    }
  
    @override
    DarkMode getSettingValue(BuildContext context)  => _isDark;
  
    @override
    void initialize(BuildContext context) async {
      var prefs = await SharedPreferences.getInstance();
      var val = prefs.get(_key);
      _isDark = val.runtimeType == int ? DarkMode.values[val] : DarkMode.system;
  }

}