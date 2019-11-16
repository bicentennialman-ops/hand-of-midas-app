class User {
  int id;
  String sid;
  String email;
  String username;
  String phoneNumber;
  String name;
  String avatar;
  String avatarUrl;

  User(this.email, this.username, this.phoneNumber, this.name, this.avatar,
      this.avatarUrl);

  Map<String, dynamic> toMap() {
    return {
      "sid": sid,
      "email": email,
      "username": username,
      "phoneNumber": phoneNumber,
      "name": name,
      "avatar": avatar,
      "avatar": avatarUrl
    };
  }

  User.fromMap(Map<String, dynamic> map) {
    sid = map["sid"];
    email = map["email"];
    username = map["username"];
    phoneNumber = map["phoneNumber"];
    name = map["name"];
    avatar = map["avatar"];
    avatarUrl = map["avatarUrl"];
  }
}
