import 'package:regex_range/regex_range.dart';
import 'package:test/test.dart';

void main() {
  test('Invalid combination', () {
    expect(() => range('a', 1), throwsA(isA<InvalidRangeTypeError>()));
    expect(() => range(1, 0), throwsA(isA<InvalidRangeInputError>()));
    expect(() => range('ab', 'z'), throwsA(isA<InvalidRangeInputError>()));
  });
}