import 'dart:async';

import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/currency_unit.dart';
import 'package:handofmidas/database/database_helper.dart';
import 'package:handofmidas/models/IconWallet.dart';
import 'package:handofmidas/models/Wallet.dart';
import 'package:handofmidas/models/WalletUser.dart';
import 'package:sqflite/sqlite_api.dart';

class WalletProvider {
  static final Future<Database> database = DatabaseHelper.internal().database;
  final currencyUnitProvider = new CurrencyUnitProvider();
  Future<Wallet> insertWallet(Wallet wallet) async {
    final Database db = await database;
    wallet.id = await db.insert(Strings.walletTable, wallet.toMap());
    return wallet;
  }

  Future<WalletUser> insertWalletUser(WalletUser walletUser) async {
    final Database db = await database;
    walletUser.id =
        await db.insert(Strings.walletUserTable, walletUser.toMap());
    return walletUser;
  }

  Future<Wallet> getWallet(int id) async {
    final Database db = await database;
    List<Map> maps = await db
        .rawQuery("SELECT * FROM ${Strings.walletTable} WHERE id=?", [id]);
    Map<String, dynamic> walletMap = Map.from(maps[0]);
    var currencyUnit =
        await currencyUnitProvider.getCurrentUnit(walletMap["currencyUnitId"]);
    walletMap["currencyUnit"] = currencyUnit.toMap();
    return Wallet.fromMap(walletMap);
  }

  Future<Wallet> getWalletBySid(String sid) async {
    final Database db = await database;
    List<Map> maps = await db
        .rawQuery("SELECT * FROM ${Strings.walletTable} WHERE sid=?", [sid]);
    Map<String, dynamic> walletMap = Map.from(maps[0]);
    var currencyUnit =
        await currencyUnitProvider.getCurrentUnit(walletMap["currencyUnitId"]);
    walletMap["currencyUnit"] = currencyUnit.toMap();
    return Wallet.fromMap(walletMap);
  }

  Future<List<Wallet>> getWallets() async {
    final Database db = await database;
    List<Map> maps = await db.rawQuery("SELECT * FROM ${Strings.walletTable};");

    List<Wallet> wallets = new List();
    for (var map in maps) {
      Map<String, dynamic> walletMap = Map.from(map);
      var currencyUnit = await currencyUnitProvider
          .getCurrentUnit(walletMap["currencyUnitId"]);
      walletMap["currencyUnit"] = currencyUnit.toMap();
      wallets.add(Wallet.fromMap(walletMap));
    }
    return wallets;
  }

  Future<List<IconWallet>> getIconWallets() async {
    final Database db = await database;
    List<Map> maps =
        await db.rawQuery("SELECT * FROM ${Strings.iconWalletTable};");
    List<IconWallet> iconWallets = new List();
    maps.forEach((map) => iconWallets.add(IconWallet.fromMap(map)));
    return iconWallets;
  }
}
