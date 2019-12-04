import 'dart:async';

import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/currency_unit.dart';
import 'package:handofmidas/database/database_helper.dart';
import 'package:handofmidas/models/Category.dart';
import 'package:handofmidas/models/IconWallet.dart';
import 'package:handofmidas/models/Wallet.dart';
import 'package:sqflite/sqlite_api.dart';

class CategoryProvider {
  static final Future<Database> database = DatabaseHelper.internal().database;
  final currencyUnitProvider = new CurrencyUnitProvider();

  Future<Category> getCategory(int id) async {
    final Database db = await database;
    List<Map> maps = await db
        .rawQuery('SELECT * FROM ${Strings.categoryTable} WHERE id=?', [id]);
    return Category.fromMap(maps[0]);
  }

  Future<Map<int, List<Category>>> getGroupCategories() async {
    final Database db = await database;
    List<Map> maps =
        await db.rawQuery("SELECT * FROM ${Strings.categoryTable};");
    Map<int, List<Category>> groupCategories = new Map();
    maps.forEach((map) {
      if (groupCategories[map["type"]] == null)
        groupCategories[map["type"]] = new List();
      groupCategories[map["type"]].add(Category.fromMap(map));
    });
    return groupCategories;
  }
}
