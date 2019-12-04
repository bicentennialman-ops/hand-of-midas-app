import 'dart:async';

import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/currency_unit.dart';
import 'package:handofmidas/database/database_helper.dart';
import 'package:handofmidas/models/Exchange.dart';
import 'package:handofmidas/models/PageIndex.dart';
import 'package:sqflite/sqlite_api.dart';

class ExchangeProvider {
  static final Future<Database> database = DatabaseHelper.internal().database;
  final currencyUnitProvider = new CurrencyUnitProvider();

  Future<List<Exchange>> getExchanges(int walletId, RangeTime rangeTime) async {
    final Database db = await database;
    List<Map> maps = await db.rawQuery(
        "SELECT e.id,e.sid,e.note,e.date,e.dateCreate,e.action,e.money,e.positionId,e.categoryId,e.userCreateId,c.code as currencyUnitCode FROM ${Strings.exchangeTable} as e,${Strings.walletTable} as w,${Strings.currencyUnitTable} as c WHERE e.walletId=? AND ?<e.date AND e.date<? AND e.walletId=w.id AND w.currencyUnitId=c.id;",
        [
          walletId,
          rangeTime.from.millisecondsSinceEpoch,
          rangeTime.to.millisecondsSinceEpoch
        ]);
    List<Exchange> exchanges = new List();
    maps.forEach((map) {
      exchanges.add(Exchange.fromMap(map));
    });
    return exchanges;
  }

  Future<double> getTotalMoney(int walletId) async {
    final Database db = await database;
    List<Map> maps = await db.rawQuery(
        "SELECT SUM(money) as total FROM ${Strings.exchangeTable} WHERE walletId=?",
        [walletId]);

    return maps[0]["total"] == null
        ? 0
        : double.parse(maps[0]["total"].toString());
  }

  Future<Exchange> insertExchange(Map<String, dynamic> exchange) async {
    final Database db = await database;
    exchange["id"] = await db.insert(Strings.exchangeTable, exchange);
    return Exchange.fromMap(exchange);
  }
}
