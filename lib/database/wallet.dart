import 'dart:async';

import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/currency_unit.dart';
import 'package:handofmidas/database/database_helper.dart';
import 'package:handofmidas/models/Wallet.dart';
import 'package:sqflite/sqlite_api.dart';

class WalletProvider {
  static final Future<Database> database = DatabaseHelper.internal().database;
  final currencyUnitProvider = new CurrencyUnitProvider();
  Future<Wallet> insertWallet(Wallet wallet) async {
    final Database db = await database;
    wallet.id = await db.insert(Strings.walletTable, wallet.toMap());
    return wallet;
  }

  Future<Wallet> getWallet(int id) async {
    final Database db = await database;
    List<Map> maps = await db
        .rawQuery("SELECT * FROM ${Strings.walletTable} WHERE id=?", [id]);
    var walletMap = maps[0];
    var currencyUnit =
        await currencyUnitProvider.getCurrentUnit(walletMap["currencyUnitId"]);
    walletMap["currencyUnit"] = currencyUnit.toMap();
    return Wallet.fromMap(maps[0]);
  }
}
