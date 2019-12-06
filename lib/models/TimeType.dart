class TimeType {
  int type;
  DateTime rootDate;
  int rangeDate;
  TimeType(this.type, this.rootDate, this.rangeDate);

  TimeType.fromMap(Map<String, dynamic> map) {
    type = map["type"];
    rootDate = map["rootDate"] != null ? DateTime.parse(map["rootDate"]) : null;
    rangeDate = map["rangeDate"];
  }

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "rootDate": rootDate.toString(),
      "rangeDate": rangeDate
    };
  }
}
