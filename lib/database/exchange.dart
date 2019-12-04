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
        "SELECT * FROM ${Strings.exchangeTable} WHERE walletId=? AND date<? AND ?<date",
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
        "SELECT SUM(c.bias*e.money) as total FROM ${Strings.exchangeTable} as e INNER JOIN ${Strings.categoryTable} as c ON e.categoryId=c.id WHERE e.walletId=?",
        [walletId]);

    return maps[0]["total"] == null
        ? 0
        : double.parse(maps[0]["total"].toString());
  }
}
