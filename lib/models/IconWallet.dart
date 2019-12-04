class IconWallet {
  String icon;
  int type;

  IconWallet(this.icon, this.type);

  Map<String, dynamic> toMap() {
    return {"icon": icon, "type": type};
  }

  IconWallet.fromMap(Map<String, dynamic> map) {
    icon = map["icon"];
    type = map["type"];
  }
}
