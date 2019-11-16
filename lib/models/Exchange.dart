import 'Image.dart';
import 'Position.dart';

import 'Person.dart';
import 'User.dart';

class Exchange {
  int id;
  String sid;
  double money;
  String note;
  User userCreate;
  DateTime dateCreate;
  DateTime date;
  Person withPerson;
  Position position;
  List<Image> images;
  String action;
  Exchange(this.id, this.sid, this.money, this.note, this.userCreate, this.date,
      this.dateCreate, this.position, this.images, this.action);
}
