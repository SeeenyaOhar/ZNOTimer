import 'package:flutter/material.dart';

import "subjectIcons.dart";
class ThemeSelector{
  Theme select(DateTime time){
    var counter = DefaultZNOCounter();
    var defaultZnoTime = counter.getZNOTime();
    if ((defaultZnoTime.inDays) / 30 > 5){
      // BLUE ZONE
    }
    if ((defaultZnoTime.inDays) / 30 > 3){
      // GREEEEEEEN ZONE
    }
    if ((defaultZnoTime.inDays) / 30 > 1){
      // YELLOW ONE
    }
    if ((defaultZnoTime.inDays / 30) < 1)
    {
      // RED ONE
    }
    throw new UnimplementedError();
  }
}

