import 'package:ZnoNeZaBarom/model/settings/settingsManager.dart';
import 'package:ZnoNeZaBarom/view/settings/general/general.dart';
import 'package:flutter/material.dart';

class SettingViewState<T extends StatefulWidget> extends State<T>{
  @override
  Widget build(BuildContext context) {
   return Container(); 
  }
  void change(SettingValue value){}
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
    return ListView(children: [ListTile(leading: Text("General"), onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> GeneralSettingsView())),)],);
  }
}


