import 'package:flutter/material.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/localizations.dart';

class PageIndex {
  int type; //0 infinity;1 one day; 2 weed;3 month;4 year; 6
  DateTime rootDate;
  int range;
  BuildContext context;

  PageIndex(this.context);

  String getTitle(int index) {
    switch (type) {
      case 0:
        var dif = DateTime.now().difference(currentDate);
        if (dif.inDays == 0)
          return AppLocalizations.of(context).toDay;
        else if (dif.inDays == 1)
          return AppLocalizations.of(context).yesterday;
        else
          return AppLocalizations.of(context).dateMonthYear(currentDate);
    }
  }

  DateTime getCurrentDate(int index) {}
}
