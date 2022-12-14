extension NumberDigit on num {
  bool get isDigit => this >= 0 && this <= 9;
  
  int get digit => toInt() % 10;

  int get others => toInt() ~/ 10;
  String get rest => others > 0 ? others.toString() : '';
  String get restLess => others > 0 ? (others - 1).toString() : '';
}