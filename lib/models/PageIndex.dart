import 'package:flutter/material.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/localizations.dart';

class PageIndex {
  int type; //0 infinity;1 one day; 2 week;3 month; 4 range; 5 year;
  DateTime rootDate;
  int rangeDate;
  BuildContext context;

  PageIndex(this.context, this.type, this.rootDate, this.rangeDate);

  getIcon() {
    switch (type) {
      case 0:
        return '${Strings.ICON}/infinity.svg';
      case 1:
        return '${Strings.ICON}/one-day.svg';
      case 2:
        return '${Strings.ICON}/week.svg';
      case 3:
        return '${Strings.ICON}/month.svg';
      case 4:
        return '${Strings.ICON}/range-day.svg';
      case 5:
        return '${Strings.ICON}/year.svg';
    }
  }

  getTitle(int index) {
    int sub = numberPage - index - 2;
    DateTime tempNow = DateTime.now();
    DateTime now = DateTime(tempNow.year, tempNow.month, tempNow.day, 0, 0, 0);
    if (sub == -1) return AppLocalizations.of(context).future;
    switch (type) {
      case 0:
        return "";
      case 1:
        DateTime currentDate =
            DateTime(rootDate.year, rootDate.month, rootDate.day - sub);
        var dif = now.difference(currentDate);
        if (dif.inDays == 0) return AppLocalizations.of(context).today;
        if (dif.inDays == 1) return AppLocalizations.of(context).yesterday;

        return AppLocalizations.of(context).dateMonthYear(currentDate);
      case 2:
        DateTime currentDate = rootDate.subtract(Duration(days: sub * 7));
        DateTime currentWeek =
            currentDate.subtract(Duration(days: currentDate.weekday - 1));
        DateTime nowWeek = now.subtract(Duration(days: now.weekday - 1));
        var dif = nowWeek.difference(currentWeek);
        if (dif.inDays == 0) return AppLocalizations.of(context).thisWeek;
        if (dif.inDays == 6) return AppLocalizations.of(context).lastWeek;

        return AppLocalizations.of(context)
            .rangeDate(currentWeek, currentWeek.add(Duration(days: 6)));
      case 3:
        DateTime currentMonth =
            DateTime(rootDate.year, rootDate.month - sub, 1);
        DateTime nowMonth = DateTime(now.year, now.month, 1);
        DateTime lastMonth = DateTime(now.year, now.month - 1, 1);
        if (nowMonth.difference(currentMonth).inDays == 0)
          return AppLocalizations.of(context).thisMonth;
        if (lastMonth.difference(currentMonth).inDays == 0)
          return AppLocalizations.of(context).lastMonth;
        return AppLocalizations.of(context).month(currentMonth);
      case 4:
        DateTime currentDate =
            rootDate.subtract(Duration(days: rangeDate * sub));
        return AppLocalizations.of(context)
            .rangeDate(currentDate, currentDate.add(Duration(days: rangeDate)));
      case 5:
        DateTime currentYear = DateTime(rootDate.year - sub, 1, 1);
        DateTime nowYear = DateTime(now.year, 1, 1);
        DateTime lastYear = DateTime(now.year - 1, 1, 1);
        if (nowYear.difference(currentYear).inDays == 0)
          return AppLocalizations.of(context).thisYear;
        if (lastYear.difference(currentYear).inDays == 0)
          return AppLocalizations.of(context).lastYear;
        return AppLocalizations.of(context).onlyYear(currentYear);
    }
  }

  rangeTime(int index) {
    int sub = numberPage - index - 2;
    DateTime tempNow = DateTime.now();
    DateTime now = DateTime(tempNow.year, tempNow.month, tempNow.day, 0, 0, 0);
    switch (type) {
      case 0:
        return RangeTime(DateTime(2015, 1, 1), now);
      case 1:
        DateTime currentDate = rootDate.subtract(Duration(days: sub));
        return RangeTime(
            DateTime(
                currentDate.year, currentDate.month, currentDate.day, 0, 0, 0),
            DateTime(currentDate.year, currentDate.month, currentDate.day, 23,
                59, 59));

      case 2:
        DateTime currentDate = rootDate.subtract(Duration(days: sub * 7));
        DateTime currentWeek =
            currentDate.subtract(Duration(days: currentDate.weekday - 1));
        DateTime endWeek = currentWeek.add(Duration(days: 6));
        return RangeTime(
            DateTime(currentWeek.year, currentWeek.month, currentWeek.day),
            DateTime(endWeek.year, endWeek.month, endWeek.day, 23, 59, 59));

      case 3:
        DateTime currentMonth =
            DateTime(rootDate.year, rootDate.month - sub, 1);
        DateTime endMonth = DateTime(rootDate.year, rootDate.month - sub + 1, 1)
            .subtract(Duration(microseconds: 1));
        return RangeTime(currentMonth, endMonth);

      case 4:
        DateTime currentDate =
            rootDate.subtract(Duration(days: rangeDate * sub));
        DateTime toDate = DateTime(currentDate.year, currentDate.month,
            currentDate.day + rangeDate, 23, 59, 59);
        return RangeTime(currentDate, toDate);
      case 5:
        DateTime currentYear = DateTime(rootDate.year - sub, 1, 1);
        DateTime toYear = DateTime(currentYear.year, 12, 31, 23, 59, 59);
        return RangeTime(currentYear, toYear);
    }
  }
}

class RangeTime {
  DateTime from;
  DateTime to;
  RangeTime(this.from, this.to);
}
