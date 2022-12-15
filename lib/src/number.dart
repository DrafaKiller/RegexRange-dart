import 'dart:math' as math;

import 'package:regex_range/src/error.dart';
import 'package:regex_range/src/utils/digit.dart';

class RegexRangeNumber {
  final int min;
  final int max;
  final int level;

  final RegexRangeNumber? negativeRange;

  RegexRangeNumber(int min, int max, [ this.level = 0 ]) :
    min = math.max(min, 0),
    max = math.max(max, 0),
    negativeRange = min < 0 ? RegexRangeNumber(math.min(max, 0).abs(), min.abs(), level) : null
  {
    if (this.min > this.max) throw InvalidRangeInputError(min, max);
  }
  
  int get difference => max - min;
  int get digitDifference => max.digit - min.digit;
  bool get overflowed => max.others - min.others > 1;

  String get tailingPattern => tail(level);

  @override
  String toString() => '(?:${
    {
      if (negativeRange != null) ...negativeRange!.rules.toList().reversed.map((element) => '-$element'),
      if (negativeRange != null && negativeRange!.min == 0 && min == 0 && max == 0) '0',
      if (!(negativeRange != null && min == 0 && max == 0)) ...rules.toList().reversed,
    }.join('|')
  })';

  RegExp get regex => RegExp(toString());

  Set<String> get rules {
    if (difference >= 10 || min.digit > max.digit) {
      return {
        if (!(level > 0 && min.digit == 9))
        '${ min.rest }${ digit(min.digit + (level > 0 ? 1 : 0), 9) }$tailingPattern',
        
        if (!(level > 0 && max.digit == 0))
        '${ max.rest }${ digit(0, max.digit - (level > 0 ? 1 : 0)) }$tailingPattern',
        
        if (overflowed) ...next.rules,
      };
    }

    return {
      '${ min.rest }${
        digit(
          min.digit + (level > 0 && digitDifference > 1 ? 1 : 0),
          max.digit - (level > 0 && digitDifference > 0 ? 1 : 0)
        )
      }$tailingPattern',
      if (overflowed) ...next.rules,
    };
  }

  RegexRangeNumber get next {
    if (difference < 10) return this;
    return RegexRangeNumber(min.others, max.others, level + 1);
  }

  static String digit(int min, int max) {
    min = math.min(math.max(min, 0), 9);
    max = math.min(math.max(max, 0), 9);

    if (min > max) throw InvalidRangeInputError(min, max);
    if (min == max) return min.toString();
    return '[$min-$max]';
  }

  static String tail(int level) {
    if (level < 1) return '';
    if (level == 1) return '[0-9]';
    return '[0-9]{$level}';
  }
}
