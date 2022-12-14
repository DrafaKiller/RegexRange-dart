import 'package:regex_range/regex_range.dart';

void main() {
  print(range(-10, 10, exact: true).hasMatch('5'));
  print(range(-10, 10, exact: true).hasMatch('-5'));
}
