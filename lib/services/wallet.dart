import 'dart:convert';

import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/models/CurrencyUnit.dart';
import 'package:handofmidas/models/Wallet.dart';
import 'package:handofmidas/services/user.dart';
import 'package:http/http.dart' as http;

Future<http.Response> addWallet(String name, int type, String avatar,
    CurrencyUnit currencyUnit, bool alert, bool incremental, num firstMoney) {
  Map<String, dynamic> wallet = new Map();
  wallet["name"] = name;
  wallet["type"] = type;
  wallet["avatar"] = avatar;
  wallet["alert"] = alert;
  wallet["incremental"] = incremental;
  wallet["firstMoney"] = firstMoney;
  wallet["currencyUnit"] = currencyUnit.sid;

  return storage.read(key: "token").then((token) {
    return http.post('${Strings.URL_API}/addWallet',
        body: jsonEncode(wallet),
        headers: {"Content-Type": "application/json", "Authorization": token});
  });
}
