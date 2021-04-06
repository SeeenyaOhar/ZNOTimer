import 'package:ZnoNeZaBarom/model/settings/settingsManager.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeSetting implements Setting<bool>{
  // this approach is kinda unprofessional but i just leave it here
  // i should have moved an interface for setting shared prefrences to another 
  final String _key = "DARK_MODE";
  bool _isDark;
  @override
  void changeSetting(SettingValue<bool> val, BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, val.getValue());
    }
  
    @override
    void getSettingValue(BuildContext context) => _isDark;
  
    @override
    void initialize(BuildContext context) async {
      var prefs = await SharedPreferences.getInstance();
      _isDark = prefs.getBool(_key);
  }

}