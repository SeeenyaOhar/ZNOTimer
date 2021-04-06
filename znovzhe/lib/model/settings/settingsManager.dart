import 'package:ZnoNeZaBarom/model/settings/general/generalModel.dart';
import 'package:flutter/cupertino.dart';

class SettingsManager{
  static initializeSettings(BuildContext context){
    settings = [DarkModeSetting()]; // add the settings classes in here
    settings.forEach((el) { el.initialize(context); });
  }
  static List<Setting> getSetting(Type typeofsetting){
    return settings.where((s)=> s.runtimeType == typeofsetting);
  }
  static List<Setting> settings = [];
}
// extend a new setting class with this class
class Setting<T>{
  T _settingValue;
  void changeSetting(SettingValue<T> val, BuildContext context) async{}
  void getSettingValue(BuildContext context) async {}
  void initialize(BuildContext context) async {}
}

  class SettingValue<T> {
    SettingValue(T value){_value = value;}
    T _value;
    T getValue() => _value;
}

  
    
