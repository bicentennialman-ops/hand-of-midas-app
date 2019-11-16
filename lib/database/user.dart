import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/database/database_helper.dart';
import 'package:handofmidas/models/User.dart';
import 'package:sqflite/sqlite_api.dart';

class UserProvider {
  static final Future<Database> database = DatabaseHelper.internal().database;

  Future<User> insertUser(User user) async {
    final Database db = await database;
    user.id = await db.insert(Strings.userTable, user.toMap());
    return user;
  }

  Future<User> getUser(int id) async {
    final Database db = await database;
    List<Map> maps = await db
        .rawQuery('SELECT * FROM ${Strings.userTable} WHERE id=?', [id]);
    return User.fromMap(maps[0]);
  }
}
