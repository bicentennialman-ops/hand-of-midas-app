import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/localizations.dart';
import 'package:handofmidas/models/Exchange.dart';

class ExchangeWidget extends StatelessWidget {
  final Exchange exchange;

  ExchangeWidget(this.exchange);

  @override
  Widget build(BuildContext context) {
    return (Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text(
                  (exchange.date.day < 10 ? "0" : "") +
                      exchange.date.day.toString(),
                  style: TextStyle(fontSize: 45.0, color: Colors.black),
                ),
                margin: Layout.mr1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).monthYearDay(exchange.date),
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    exchange.note,
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              )
            ],
          ),
          Text(
            AppLocalizations.of(context).money(exchange.money.abs(), "VND"),
            style: Theme.of(context).textTheme.display3.copyWith(
                color: exchange.money < 0
                    ? negativeMoneyColor
                    : positiveMoneyColor),
          )
        ]));
  }
}
