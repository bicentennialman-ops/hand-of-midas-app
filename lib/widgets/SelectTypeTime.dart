import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/localizations.dart';

class SelectTypeTimeDialog extends StatelessWidget {
  final selectType;

  SelectTypeTimeDialog(this.selectType);
//0 infinity;1 one day; 2 week;3 month; 4 range; 5 year;
  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: dialogBorderRadius),
      child: Padding(
        padding: EdgeInsets.all(Layout.p4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _Option("date.svg", AppLocalizations.of(context).selectDay,
                AppLocalizations.of(context).dateMonthYear(DateTime.now()), () {
              DatePicker.showDatePicker(context,
                  locale: AppLocalizations.of(context).localType,
                  onConfirm: (date) {
                selectType(1, date, null);
              });
            }),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              controller: new ScrollController(keepScrollOffset: false),
              children: <Widget>[
                _Option("infinity.svg", AppLocalizations.of(context).all, null,
                    () => selectType(0, DateTime.now(), null)),
                _Option("range-day.svg",
                    AppLocalizations.of(context).selectRange, null, () {
                  DateTime from, to;
                  DatePicker.showDatePicker(context,
                      locale: AppLocalizations.of(context).localType,
                      onConfirm: (date) {
                    from = date;
                    DatePicker.showDatePicker(context,
                        minTime: from,
                        locale: AppLocalizations.of(context).localType,
                        onConfirm: (date) {
                      to = date;
                      selectType(4, from, to.difference(from).inDays);
                    });
                  });
                }),
                _Option(
                    "week.svg",
                    AppLocalizations.of(context).week,
                    AppLocalizations.of(context)
                        .rangeDate(
                            today.subtract(Duration(days: today.weekday - 1)),
                            today.add(Duration(days: 7 - today.weekday)))
                        .replaceAll("-", " "),
                    () => selectType(2, DateTime.now(), null)),
                _Option(
                    "one-day.svg",
                    AppLocalizations.of(context).today,
                    AppLocalizations.of(context).dateMonthYear(today),
                    () => selectType(1, DateTime.now(), null)),
                _Option(
                    "year.svg",
                    AppLocalizations.of(context).year,
                    AppLocalizations.of(context).onlyYear(today),
                    () => selectType(5, DateTime.now(), null)),
                _Option(
                    "month.svg",
                    AppLocalizations.of(context).selectMonth,
                    AppLocalizations.of(context).month(today),
                    () => selectType(3, DateTime.now(), null))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final action;
  final String icon;
  final String title;
  final String subtitle;
  _Option(this.icon, this.title, this.subtitle, this.action);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => action(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
              height: iconSize,
              width: iconSize,
              child: SvgPicture.asset("${Strings.ICON}/$icon")),
          Text(
            title,
            style: Theme.of(context).textTheme.body1,
          ),
          Text(
            subtitle != null ? subtitle : "",
            style: Theme.of(context).textTheme.subtitle,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
