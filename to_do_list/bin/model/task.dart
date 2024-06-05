class Task {
  static int count = 0;
  int? _number;
  String? _name;
  String? _description;
  bool? _isDone;
  DateTime? _dateFrom;
  DateTime? _dateTo;
  Task() {
    _number = ++count;
  }

  int get number => _number!;
  String get name => _name!;
  String get description => _description!;
  bool get isDone => _isDone!;
  DateTime get dateFrom => _dateFrom!;
  DateTime get dateTo => _dateTo!;

  set number(int n) => _number = n;
  set name(String n) => _name = n;
  set description(String d) => _description = d;
  set isDone(bool b) => _isDone = b;
  set dateFrom(DateTime d) => _dateFrom = d;
  set dateTo(DateTime d) => _dateTo = d;
}
