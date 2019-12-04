import 'User.dart';

class WalletUser {
  int id;
  User user;
  String role;

  WalletUser(this.user, this.role);

  Map<String, dynamic> toMap() {
    return {"userId": user.id, "role": role};
  }

  WalletUser.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    user = User.fromMap(map["user"]);
    role = map["role"];
  }
}
