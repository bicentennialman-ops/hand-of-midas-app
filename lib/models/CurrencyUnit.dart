class CurrencyUnit {
  int id;
  String sid;
  String name;
  String code;
  String avatar;
  String character;
  String format;
  String decimalSeparator;
  String groupingSeparator;

  CurrencyUnit(this.id, this.sid, this.name, this.code, this.character,
      this.format, this.decimalSeparator, this.groupingSeparator);

  CurrencyUnit.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    sid = map["sid"];
    name = map["name"];
    code = map["code"];
    avatar = map["avatar"];
    character = map["character"];
    format = map["format"];
    decimalSeparator = map["decimalSeparator"];
    groupingSeparator = map["groupingSeparator"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "sid": sid,
      "name": name,
      "code": code,
      "avatar": avatar,
      "character": character,
      "format": format,
      "decimalSeparator": decimalSeparator,
      "groupingSeparator": groupingSeparator
    };
  }
}
