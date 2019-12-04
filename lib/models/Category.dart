class Category {
  int id;
  String sid;
  String code;
  String name;
  int type;
  int bias;
  String avatar;
  String avatarUrl;
  Category parent;
  int parentId;

  Category(this.sid, this.code, this.name, this.type, this.bias, this.avatar,
      this.avatarUrl, this.parent);

  Category.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    sid = map["sid"];
    code = map["code"];
    type = map["type"];
    bias = map["bias"];
    avatar = map["avatar"];
    avatarUrl = map["avatarUrl"];
    parentId = map["parentId"];
  }
}
