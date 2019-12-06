import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/database/category.dart';
import 'package:handofmidas/database/exchange.dart';
import 'package:handofmidas/localizations.dart';

import 'package:handofmidas/models/GroupExchanges.dart';
import 'package:handofmidas/models/PageIndex.dart';
import 'package:handofmidas/widgets/GroupExchanges.dart';

class ListExchangesPageWidget extends StatefulWidget {
  ListExchangesPageWidget(this.rangeTime, this.walletId);

  final RangeTime rangeTime;
  final int walletId;
  @override
  _ListExchangesPageState createState() => _ListExchangesPageState();
}

class _ListExchangesPageState extends State<ListExchangesPageWidget>
    with SingleTickerProviderStateMixin {
  List<GroupExchanges> _groups = [];
  @override
  void initState() {
    super.initState();
    List<GroupExchanges> groups = [];
    ExchangeProvider()
        .getExchanges(widget.walletId, widget.rangeTime)
        .then((exchanges) async {
      for (var exchange in exchanges) {
        bool isNew = true;
        for (var index = 0; index < groups.length; index++) {
          var groupExchange = groups[index];
          if (groupExchange.category.id == exchange.categoryId) {
            groupExchange.exchanges.add(exchange);
            isNew = false;
            break;
          }
        }
        if (isNew)
          groups.add(GroupExchanges(
              await CategoryProvider().getCategory(exchange.categoryId),
              [exchange]));
      }
      this.setState(() {
        _groups = groups;
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
            itemCount: _groups.length,
            itemBuilder: (context, index) {
              var group = _groups[index];
              return Container(
                  margin: Layout.mb2, child: GroupExchangesWidget(group));
            },
          )),
    ));
  }
}
