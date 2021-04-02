
import 'package:flutter/cupertino.dart';

import '../../viewmodel/languageManager.dart';

class DurationTimeConverter {
  static String shortTimeString(Duration time, BuildContext context) {
    var buffer = new StringBuffer();
    var monthsLeft = time.inDays / 30;
    var days = ((monthsLeft - monthsLeft.floor()) * 30).floor();
    var months = monthsLeft.floor();
    bool monthsWritten = true;
    if (monthsLeft != 0) {
      var monthsString = "";
      var lastNumberMonth = monthsLeft % 10;
      if (months < 10){
        if (months == 1) {
          monthsString = LocalizationTool.of(context).months1;
        } else if (months < 5) {
          monthsString = LocalizationTool.of(context).months234;
        } else {
          monthsString = LocalizationTool.of(context).months5;
        }
      }
      else
      if (lastNumberMonth == 1) {
        monthsString = LocalizationTool.of(context).months1;
      } else if (lastNumberMonth < 5) {
        monthsString = LocalizationTool.of(context).months234;
      } else {
        monthsString = LocalizationTool.of(context).months5;
      }

      buffer.write("${monthsLeft.floor()} $monthsString");
    }
    if (days != 0) {
      var daysString = "";
      var lastNumberDay = (days % 10).floor();
      if (days > 10 && days < 20) {
        daysString = LocalizationTool.of(context).days5;
      } else if (days < 10){
        if (days == 1) {
          daysString = LocalizationTool.of(context).days1;
        } else if (days < 5) {
          daysString = LocalizationTool.of(context).days234;
        } else {
          daysString = LocalizationTool.of(context).days5;
        }
      }
      else{
        if (lastNumberDay == 1) {
          daysString = LocalizationTool.of(context).days1;
        } else if (lastNumberDay < 5) {
          daysString = LocalizationTool.of(context).days234;
        } else {
          daysString = LocalizationTool.of(context).days5;
        }
      }
      if (monthsWritten) {
        buffer.write(",\n${days.floor()} $daysString");
      } else {
        buffer.write("${days.floor()} $daysString");
      }
    }
    return buffer.toString();
  }
}