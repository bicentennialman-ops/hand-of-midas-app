import 'dart:convert';

import 'package:handofmidas/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();
Future<http.Response> login(String login, String password) {
  Map<String, dynamic> user = new Map();
  user["login"] = login;
  user["password"] = password;
  return http.post(
    '${Strings.URL_API}/login',
    body: jsonEncode(user),
    headers: {"Content-Type": "application/json"},
  );
}

Future<String> renewToken(String token) {
  return http.get('${Strings.URL_API}/renewToken', headers: {
    "Content-Type": "application/json",
    "Authorization": token
  }).then((res) {
    if (res.statusCode == 200) {
      return jsonDecode(res.body)["token"];
    } else
      return "";
  });
}

Future<http.Response> getUserInfor() {
  return storage.read(key: "token").then((token) {
    return http.get('${Strings.URL_API}/getUserInfor',
        headers: {"Content-Type": "application/json", "Authorization": token});
  });
}
