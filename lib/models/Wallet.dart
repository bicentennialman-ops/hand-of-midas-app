import 'package:handofmidas/models/CurrencyUnit.dart';
import 'package:handofmidas/models/WalletUser.dart';

import 'User.dart';

class Wallet {
  int id;
  String sid;
  int type;
  String name;
  CurrencyUnit currencyUnit;
  String avatar;
  User userCreate;
  List<WalletUser> walletUsers;
  String destionation;
  String note;
  DateTime createDate;
  DateTime updateDate;
  DateTime startDate;
  DateTime endDate;
  String action;
  num firstMoney;
  num money;

  Wallet(
      this.id,
      this.sid,
      this.name,
      this.type,
      this.currencyUnit,
      this.avatar,
      this.userCreate,
      this.walletUsers,
      this.destionation,
      this.note,
      this.createDate,
      this.updateDate,
      this.startDate,
      this.endDate,
      this.firstMoney,
      this.action);

  Map<String, dynamic> toMap() {
    return {
      "sid": sid,
      "type": type,
      "currencyUnitId": currencyUnit.id,
      "avatar": avatar,
      "userCreateId": userCreate.id,
      "createDate": createDate.millisecondsSinceEpoch,
      "updateDate": updateDate.millisecondsSinceEpoch,
      "action": action,
      "startDate": startDate != null ? startDate.millisecondsSinceEpoch : -1,
      "endDate": endDate != null ? endDate.millisecondsSinceEpoch : -1,
      "note": note,
      "destionation": destionation,
      "name": name,
      "firstMoney": firstMoney
    };
  }

  Wallet.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    sid = map["sid"];
    type = map["type"];
    avatar = map["avatar"];
    createDate = DateTime.fromMillisecondsSinceEpoch(map["createDate"]);
    updateDate = DateTime.fromMillisecondsSinceEpoch(map["updateDate"]);
    action = map["action"];
    startDate = map["startDate"] != null
        ? DateTime.fromMillisecondsSinceEpoch(map["startDate"])
        : null;
    startDate = map["endDate"] != null
        ? DateTime.fromMillisecondsSinceEpoch(map["endDate"])
        : null;
    note = map["note"];
    destionation = map["destionation"];
    currencyUnit = CurrencyUnit.fromMap(map["currencyUnit"]);
    name = map["name"];
    firstMoney = map["firstMoney"];
  }
}
