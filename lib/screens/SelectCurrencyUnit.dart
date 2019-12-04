import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/currency_unit.dart';
import 'package:handofmidas/models/CurrencyUnit.dart';

import '../localizations.dart';

class SelectCurrencyUnitScreen extends StatelessWidget {
  final selectCurrencyUnit;
  final List<CurrencyUnit> currencyUnits;
  SelectCurrencyUnitScreen(this.selectCurrencyUnit, this.currencyUnits);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: PreferredSize(
            preferredSize: Size(null, appBarHeigh),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BackButton(),
                  Text(AppLocalizations.of(context).currencyUnit,
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.black)),
                  SizedBox(
                    width: iconSize,
                  )
                ],
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: this.currencyUnits.length,
            itemBuilder: (context, index) {
              var currencyUnit = this.currencyUnits[index];
              return FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () => this.selectCurrencyUnit(currencyUnit),
                child: Container(
                  margin: Layout.mt1,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.all(Layout.p1),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: iconSize,
                          width: iconSize,
                          child: SvgPicture.asset(
                              '${Strings.AVATAR_CURRENCY_UNIT}/${currencyUnit.avatar}'),
                        ),
                        SizedBox(
                          width: Layout.m2,
                        ),
                        Text(
                          '(${currencyUnit.code}) ${currencyUnit.name}',
                          style: Theme.of(context).textTheme.body1,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
