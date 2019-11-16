import 'package:handofmidas/models/CurrencyUnit.dart';
import 'package:handofmidas/models/WalletUser.dart';

import 'User.dart';

class Wallet {
  int id;
  String sid;
  int type;
  CurrencyUnit currencyUnit;
  String avatar;
  User userCreate;
  List<WalletUser> walletUsers;
  num destionation;
  String note;
  DateTime createDate;
  DateTime updateDate;
  DateTime startDate;
  DateTime endDate;
  String action;
  Wallet(
      this.id,
      this.sid,
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
      this.action);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "sid": sid,
      "type": type,
      "currentUnitId": currencyUnit.id,
      "avatar": avatar,
      "userCreateId": userCreate.id,
      "createDate": createDate.millisecondsSinceEpoch,
      "updateDate": updateDate.millisecondsSinceEpoch,
      "action": action,
      "startDate": startDate != null ? startDate.millisecondsSinceEpoch : -1,
      "endDate": endDate != null ? endDate.millisecondsSinceEpoch : -1,
      "note": note,
      "destionation": destionation
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
  }
}
