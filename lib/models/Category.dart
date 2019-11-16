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
  Category(this.sid, this.code, this.name, this.type, this.bias, this.avatar,
      this.avatarUrl, this.parent);
}
