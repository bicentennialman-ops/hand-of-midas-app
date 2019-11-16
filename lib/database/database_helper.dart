import 'package:handofmidas/constants/strings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    var db = await openDatabase(
        join(await getDatabasesPath(), Strings.databaseFile),
        onCreate: _onCreate,
        version: 1);
    return db;
  }

  _onCreate(Database db, int newVersion) async {
    print("Create table");
    Batch batch = db.batch();
    batch.execute('''
          CREATE TABLE ${Strings.currencyUnitTable}(id INTEGER PRIMARY KEY AUTOINCREMENT, sid TEXT NOT NULL, name TEXT NOT NULL, code TEXT NOT NULL,avatar TEXT NOT NULL, character TEXT NOT NULL,format TEXT NOT NULL,decimalSeparator TEXT NOT NULL,groupingSeparator TEXT NOT NULL); 
        ''');

    batch.execute('''
          CREATE TABLE ${Strings.categoryTable}(id INTEGER PRIMARY KEY AUTOINCREMENT,sid TEXT,code TEXT,name TEXT,type INTEGER,avatar TEXT NOT NULL,avatarUrl TEXT NOT NULL)
     ''');

    batch.execute('''
         CREATE TABLE ${Strings.exchangeTable}(id INTEGER PRIMARY KEY AUTOINCREMENT,sid TEXT,money REAL,note TEXT,
                  userCreateId INTEGER,dateCreate INTEGER NOT NULL,walletId INTEGER NOT NULL,
                  date INTEGER NOT NULL,withPersonId INTEGER,positionId INTEGER,action TEXT,
          FOREIGN KEY(withPersonId) REFERENCES ${Strings.personTable}(id), FOREIGN KEY(positionId) REFERENCES ${Strings.positionTable}(id),
          FOREIGN KEY(userCreateId) REFERENCES ${Strings.userTable}(id), FOREIGN KEY(walletId) REFERENCES ${Strings.walletTable}(id));
     ''');

    batch.execute('''
        CREATE TABLE ${Strings.imageTable}(id INTEGER PRIMARY KEY AUTOINCREMENT,url TEXT,exchangeId INTEGER NOT NULL,path TEXT NOT NULL, FOREIGN KEY(exchangeId) REFERENCES ${Strings.exchangeTable}(id));
     ''');

    batch.execute('''
        CREATE TABLE ${Strings.personTable}(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phoneNumber TEXT, userId INTEGER);
     ''');

    batch.execute('''
        CREATE TABLE ${Strings.positionTable}(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,
          lat STRING, long STRING);
     ''');

    batch.execute('''
        CREATE TABLE ${Strings.userTable}(id INTEGER PRIMARY KEY AUTOINCREMENT, sid TEXT NOT NULL, email TEXT, username TEXT, phoneNumber TEXT, name TEXT,avatar TEXT);
     ''');

    batch.execute('''
        CREATE TABLE ${Strings.walletTable}(id INTEGER PRIMARY KEY AUTOINCREMENT, sid TEXT, type INTEGER NOT NULL, currencyUnitId INTEGER, avatar TEXT NOT NULL,userCreateId INTEGER NOT NULL,destionation REAL,note TEXT,createDate INTEGER NOT NULL,updateDate INTEGER NOT NULL,startDate INTEGER, endDate INTEGER,action TEXT, FOREIGN KEY(userCreateId) REFERENCES ${Strings.userTable}(id));
     ''');

    batch.execute('''
        CREATE TABLE ${Strings.walletUserTable}(id INTEGER PRIMARY KEY AUTOINCREMENT,userId INTEGER NOT NULL,role TEXT NOT NULL, FOREIGN KEY(userId) REFERENCES ${Strings.userTable}(id));
     ''');
    print("Create table success");

    print("Insert data");
    batch.execute('''
     INSERT INTO ${Strings.currencyUnitTable}(sid,name,code,character,avatar,format,decimalSeparator,groupingSeparator)
          VALUES ("5dc14f7c5fb4cb0c53099cbf","Việt Nam đồng","VND","₫","vietnam.svg","#,###",".",","),
                  ("5dc7f08d214b4e638433296f","Dola","USD","\$","united-states.svg","#,##0.00",",",".");
    ''');
    await batch.commit();
  }
}
