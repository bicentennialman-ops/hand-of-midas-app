import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/models/Category.dart';
import 'package:handofmidas/models/Exchange.dart';
import 'package:handofmidas/models/GroupExchanges.dart';
import 'package:handofmidas/widgets/Exchange.dart';
import '../constants/app_themes.dart';
import '../localizations.dart';

class GroupExchangesWidget extends StatelessWidget {
  final GroupExchanges groupExchanges;

  GroupExchangesWidget(this.groupExchanges);

  @override
  Widget build(BuildContext context) {
    Category category = groupExchanges.category;
    List<Exchange> exchanges = groupExchanges.exchanges;
    return (Container(
        color: Colors.white,
        child: Padding(
          padding: paddingSection,
          child: Column(
            children: <Widget>[
              _Cateogry(
                  category,
                  exchanges.length,
                  exchanges.fold(
                      0, (value, exchange) => value + exchange.money)),
              Divider(),
              _Exchanges(exchanges)
            ],
          ),
        )));
  }
}

class _Cateogry extends StatelessWidget {
  final Category category;
  final int count;
  final double money;

  _Cateogry(this.category, this.count, this.money);

  @override
  Widget build(BuildContext context) {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: Layout.mr1,
                  height: avatarSize,
                  width: avatarSize,
                  child: ClipRRect(
                      borderRadius: avatarBorderRadius,
                      child: SvgPicture.asset(
                          '${Strings.AVATAR_CATEGORY}/${category.avatar}')),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      category.code == null
                          ? category.name
                          : AppLocalizations.of(context)
                              .categoryName(category.code),
                      style: Theme.of(context).textTheme.display3,
                    ),
                    Text(AppLocalizations.of(context).countExchanges(count),
                        style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            )
          ],
        ),
        Text(AppLocalizations.of(context).money(money.abs(), "VND"),
            style: Theme.of(context).textTheme.display3)
      ],
    ));
  }
}

class _Exchanges extends StatelessWidget {
  final List<Exchange> exchanges;

  _Exchanges(this.exchanges);

  @override
  Widget build(BuildContext context) {
    // T implement buildODO:
    return (Column(
      children: exchanges
          .map((exchange) => Container(
                child: ExchangeWidget(exchange),
                margin: Layout.mb2,
              ))
          .toList(),
    ));
  }
}
