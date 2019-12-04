import 'dart:convert';

import 'package:handofmidas/constants/strings.dart';
import 'package:handofmidas/models/Category.dart';
import 'package:handofmidas/models/Wallet.dart';
import 'package:handofmidas/services/user.dart';
import 'package:http/http.dart' as http;

Future<http.Response> addExchange(Wallet wallet, double money, String note,
    DateTime date, DateTime dateCreate, Category category) {
  Map<String, dynamic> exchange = new Map();
  exchange["wallet"] = wallet.sid;
  exchange["money"] = money;
  if (note != null) exchange["note"] = note;
  exchange["date"] = date.toString();
  exchange["category"] = category.sid;
  exchange["dateCreate"] = dateCreate.toString();
  return storage.read(key: "token").then((token) {
    return http.post('${Strings.URL_API}/addExchange',
        body: jsonEncode(exchange),
        headers: {"Content-Type": "application/json", "Authorization": token});
  });
}
