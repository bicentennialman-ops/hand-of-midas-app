import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/database/category.dart';
import 'package:handofmidas/database/exchange.dart';
import 'package:handofmidas/localizations.dart';
import 'package:handofmidas/models/Category.dart';
import 'package:handofmidas/models/Exchange.dart';
import 'package:handofmidas/models/GroupExchanges.dart';
import 'package:handofmidas/models/PageIndex.dart';

class ListExchangesPageWidget extends StatefulWidget {
  ListExchangesPageWidget(this.rangeTime, this.walletId);

  final RangeTime rangeTime;
  final int walletId;
  @override
  _ListExchangesPageState createState() => _ListExchangesPageState();
}

class _ListExchangesPageState extends State<ListExchangesPageWidget>
    with SingleTickerProviderStateMixin {
  List<GroupExchanges> groups;
  @override
  void initState() {
    super.initState();
    groups = [];
    ExchangeProvider()
        .getExchanges(widget.walletId, widget.rangeTime)
        .then((exchanges) {
      exchanges.forEach((exchange) async {
        var index = groups.indexWhere((groupExchange) {
          if (groupExchange.category.id == exchange.categoryId)
            return true;
          else
            return false;
        });
        if (index >= 0)
          groups[index].exchanges.add(exchange);
        else
          groups.add(GroupExchanges(
              await CategoryProvider().getCategory(exchange.categoryId),
              [exchange]));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
      child: Padding(
          padding: Layout.pt2,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: Layout.mb2,
                  child: Text(AppLocalizations.of(context)
                      .rangeDate(widget.rangeTime.from, widget.rangeTime.to)));
            },
          )),
    ));
  }
}
