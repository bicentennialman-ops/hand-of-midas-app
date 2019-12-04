import 'package:handofmidas/database/user.dart';
import 'package:handofmidas/models/Category.dart';

import 'Image.dart';
import 'Position.dart';

import 'Person.dart';
import 'User.dart';

class Exchange {
  int id;
  String sid;
  double money;
  String note;
  User userCreate;
  int userCreateId;
  DateTime dateCreate;
  DateTime date;
  int withPersonId;
  int positionId;
  List<Image> images;
  int walletId;
  String action;
  Category category;
  int categoryId;
  String currencyUnitCode;
  int bias;

  Exchange(this.id, this.sid, this.money, this.note, this.userCreate, this.date,
      this.dateCreate, this.positionId, this.images, this.action);

  Exchange.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    walletId = map["walletId"];
    note = map["note"];
    userCreateId = map["userCreateId"];
    money = map["money"];
    sid = map["sid"];
    currencyUnitCode = map["currencyUnitCode"];
    dateCreate = DateTime.fromMillisecondsSinceEpoch(map["dateCreate"]);
    date = DateTime.fromMillisecondsSinceEpoch(map["date"]);
    positionId = map["positionId"];
    withPersonId = map["withPersonId"];
    action = map["action"];
    categoryId = map["categoryId"];
  }

  Map<String, dynamic> toMap() {
    return {
      "sid": sid,
      "walletId": walletId,
      "note": note,
      "money": money,
      "date": date.millisecondsSinceEpoch,
      "dateCreate": dateCreate.millisecondsSinceEpoch,
      "userCreateId": userCreateId,
      "categoryId": categoryId
    };
  }
}
