import 'package:regex_range/src/main.dart';
import 'package:test/test.dart';

void main() {
  test('a-z', () {
    final expression = range('a', 'z');

    expect(expression.hasMatch('a'), isTrue);
    expect(expression.hasMatch('z'), isTrue);
    expect(expression.hasMatch('b'), isTrue);
    expect(expression.hasMatch('y'), isTrue);
    
    expect(expression.hasMatch('A'), isFalse);
    expect(expression.hasMatch('Z'), isFalse);
    expect(expression.hasMatch('0'), isFalse);
  });

  test('A-Z' , () {
    final expression = range('A', 'Z');

    expect(expression.hasMatch('A'), isTrue);
    expect(expression.hasMatch('Z'), isTrue);
    expect(expression.hasMatch('B'), isTrue);
    expect(expression.hasMatch('Y'), isTrue);
    
    expect(expression.hasMatch('a'), isFalse);
    expect(expression.hasMatch('z'), isFalse);
    expect(expression.hasMatch('0'), isFalse);
  });

  test('a-zA-Z', () {
    final expression = range('a', 'Z');

    expect(expression.hasMatch('a'), isTrue);
    expect(expression.hasMatch('z'), isTrue);
    expect(expression.hasMatch('A'), isTrue);
    expect(expression.hasMatch('Z'), isTrue);

    expect(expression.hasMatch('b'), isTrue);
    expect(expression.hasMatch('y'), isTrue);
    expect(expression.hasMatch('B'), isTrue);
    expect(expression.hasMatch('Y'), isTrue);

    expect(expression.hasMatch('0'), isFalse);
  });

  test('L-O', () {
    final expression = range('L', 'O');

    expect(expression.hasMatch('L'), isTrue);
    expect(expression.hasMatch('O'), isTrue);

    expect(expression.hasMatch('M'), isTrue);
    expect(expression.hasMatch('N'), isTrue);
    
    expect(expression.hasMatch('K'), isFalse);
    expect(expression.hasMatch('P'), isFalse);
    expect(expression.hasMatch('0'), isFalse);
  });
}
