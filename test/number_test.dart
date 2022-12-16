import 'package:regex_range/regex_range.dart';
import 'package:test/test.dart';

/* -= Expected Result =- 
  From 534 to 3837:
    > 53[4-9]|5[4-9][0-9]|[6-9][0-9][0-9]|[1-2][0-9][0-9][0-9]|3[0-7][0-9][0-9]|38[0-2][0-9]|383[0-7]

  From 534 to 785:
    > 53[4-9]|5[4-9][0-9]|6[0-9][0-9]|7[0-7][0-9]|78[0-5]

  From 534 to 568:
    > 53[4-9]|5[4-5][0-9]|56[0-8]

  From 534 to 538:
    > 53[4-8]

  -= Other Results =-

  From 25 to 50:
    > 2[5-9]|[3-4][0-9]|50

  From 25 to 59:
    > 2[5-9]|[3-5][0-9] (MAYBE AVOID THIS FOR SIMPLICITY) Instead: 2[5-9]|[3-4][0-9]|5[0-9]
    
  From 25 to 58:
    > 2[5-9]|[3-4][0-9]|5[0-8]

  From 25 to 69:
    > 2[5-9]|[4-5][0-9]|6[0-9]

  -= Optimized Results =-

  The digit pattern "[0-9][0-9][0-9]" can be replaced with "[0-9]{3}" for a shorter regex pattern.
*/

void rangeTest(int min, int max) {
  final globalPattern = range(min, max, exact: true);
  
  for (var i = min - 1000; i <= max + 1000; i++) {
    expect(globalPattern.hasMatch(i.toString()), i >= min && i <= max);
  }
}

void main() {
  test('level 1', () {
    rangeTest(0, 0);
    rangeTest(0, 9);
    rangeTest(4, 5);
  });

  test('level 2', () {
    rangeTest(0, 10);
    rangeTest(10, 20);
    rangeTest(15, 20);
    rangeTest(25, 50);
    rangeTest(25, 75);
  });

  test('level 3', () {
    rangeTest(0, 100);
    rangeTest(100, 200);
    rangeTest(150, 200);
    rangeTest(250, 500);
    rangeTest(250, 750);
  });

  test('level 4', () {
    rangeTest(0, 1000);
    rangeTest(100, 1000);
    rangeTest(250, 2000);
    rangeTest(250, 1050);
    rangeTest(534, 3837);
  });

  test('level 5', () {
    rangeTest(0, 10000);
    rangeTest(100, 10000);
    rangeTest(250, 20000);
    rangeTest(250, 10500);
    rangeTest(534, 38378);
  });

  test('level 6', () {
    rangeTest(0, 200000);
    rangeTest(125, 200000);
  });

  test('level -1', () {
    rangeTest(-1, 0);
    // rangeTest(-75, -25);
    // rangeTest(-2500, -100);
    // rangeTest(-2050, -1050);
    // rangeTest(-3859, -1283);
  });
}