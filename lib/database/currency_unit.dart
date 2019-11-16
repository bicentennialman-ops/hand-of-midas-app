import 'dart:async';
import 'dart:async' as prefix0;

import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/database_helper.dart';
import 'package:handofmidas/models/CurrencyUnit.dart';
import 'package:sqflite/sqlite_api.dart';

class CurrencyUnitProvider {
  static final Future<Database> database = DatabaseHelper.internal().database;

  Future<void> insertCurrentUnits(List<CurrencyUnit> currencyUnits) async {
    final Database db = await database;
    var batch = db.batch();
    currencyUnits
        .forEach((cu) => batch.insert(Strings.currencyUnitTable, cu.toMap()));
    await batch.commit();
  }

  Future<CurrencyUnit> getCurrentUnit(int id) async {
    final Database db = await database;
    List<Map> maps = await db.rawQuery(
        'SELECT * FROM ${Strings.currencyUnitTable} WHERE id=?', [id]);
    return CurrencyUnit.fromMap(maps[0]);
  }

  Future<List<CurrencyUnit>> getCurrentUnits() async {
    final Database db = await database;
    List<Map> maps =
        await db.rawQuery('SELECT * FROM ${Strings.currencyUnitTable};');
    List<CurrencyUnit> currencyUnits = new List();
    maps.forEach((map) => currencyUnits.add(CurrencyUnit.fromMap(map)));
    return currencyUnits;
  }
}
