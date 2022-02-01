
import 'package:flutter/cupertino.dart';

import '../../viewmodel/languageManager.dart';

class DurationTimeConverter {
  static String shortTimeString(Duration time, BuildContext context) {
    var buffer = new StringBuffer();
    var monthsLeft = time.inDays / 30;
    var days = ((monthsLeft - monthsLeft.floor()) * 30).round();
    var months = monthsLeft.floor();
    if (monthsLeft < 0){
      buffer.write(LocalizationTool.of(context).counterGone);
      return buffer.toString().toUpperCase();
    }
    bool monthsWritten = true;
    if (monthsLeft.floor() != 0) {
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
    else{
      monthsWritten = false;
    }
    if (days.round() != 0) {
      var daysString = "";
      var lastNumberDay = (days % 10).round();
      
      if (days >= 10 && days < 20) {
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
        buffer.write(",\n${days.round()} $daysString");
      } else {
        buffer.write("${days.round()} $daysString");
      }
    }
    else{
      if (!monthsWritten){
        buffer.write(LocalizationTool.of(context).lessThanDay);
      }
      
      
    }
    return buffer.toString();
  }
}