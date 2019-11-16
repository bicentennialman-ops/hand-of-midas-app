import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handofmidas/constants/app_themes.dart';
import 'package:handofmidas/models/Category.dart';
import 'package:handofmidas/models/Exchange.dart';
import 'package:handofmidas/models/GroupExchanges.dart';

import 'GroupExchanges.dart';

class ListExchangesPageWidget extends StatefulWidget {
  ListExchangesPageWidget(this.indexPage);
  final int indexPage;
  @override
  _ListExchangesPageState createState() => _ListExchangesPageState();
}

class _ListExchangesPageState extends State<ListExchangesPageWidget>
    with SingleTickerProviderStateMixin {
  List<GroupExchanges> groups;
  @override
  void initState() {
    super.initState();
    groups = List.from([
      GroupExchanges(
          Category('010292djdjddjdjdjdjd', 'debt', null, 0, -1, 'debt.svg',
              null, null),
          List.from([
            Exchange(null, 'idServer', -1000000, 'Ha noi hom nay', null,
                DateTime.now(), DateTime.now(), null, null, null),
            Exchange(null, 'idServer', -1230000, 'Ha noi hom nay', null,
                DateTime.now(), DateTime.now(), null, null, null),
            Exchange(null, 'idServer', -500000, 'Ha noi hom nay', null,
                DateTime.now(), DateTime.now(), null, null, null)
          ]))
    ]);
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
                  child: GroupExchangesWidget(groups[index]));
            },
          )),
    ));
    ;
  }
}
