import 'dart:convert';

import 'package:handofmidas/services/user.dart' as userService;

Future<Map<String, dynamic>> setup(String key, dynamic value) async {
  Map<String, dynamic> setting =
      jsonDecode(await userService.storage.read(key: "setting"));
  setting[key] = value;
  await userService.storage.write(key: "setting", value: jsonEncode(setting));
  return setting;
}

Future<Map<String, dynamic>> getSetting() async {
  String settingString = await userService.storage.read(key: "setting");
  if (settingString == null)
    return null;
  else
    return jsonDecode(settingString);
}
