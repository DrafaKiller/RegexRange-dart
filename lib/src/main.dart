import 'package:regex_range/src/error.dart';
import 'package:regex_range/src/number.dart';
import 'package:regex_range/src/utils/case.dart';
import 'package:regex_range/src/utils/regex.dart';

/// To generate a regex, you may use the `range` function to generate
/// both number and character ranges, depending on what's passed in.
/// A number range is generated when passing in 2 numbers,
/// and a character range is generated when passing in 2 strings with a length of 1.
/// 
/// Alternatively, you may use the `numberRange` and `charRange` functions to generate a number or character range, respectively.
/// 
/// ```dart
/// range(0, 100, exact: true).hasMatch('50');
/// range(-50, 50, exact: true).hasMatch('-25');
/// 
/// range('a', 'z').hasMatch('b');
/// range('A', 'Z').hasMatch('B');
/// range('a', 'Z')..hasMatch('b')..hasMatch('B');
/// ```
RegExp range<T>(T min, T max, { bool exact = false }) {
  if (min is int && max is int) {
    return numberRange(min, max, exact: exact);
  } else if (min is String && max is String) {
    return charRange(min, max, caseSensitive: !isDifferentCase(min, max), exact: exact);
  } else {
    throw InvalidRangeTypeError(T);
  }
}

/// Generates a number range.
/// 
/// ```dart
/// final regex = numberRange(-10, 10, exact: true);
/// 
/// print(regex.hasMatch('-5')); // true
/// print(regex.hasMatch('5')); // true
/// print(regex.hasMatch('11')); // false
/// ```
RegExp numberRange(int min, int max, { bool exact = false }) {
  return RegexRangeNumber(min, max).regex.shouldBeExact(exact);
}

/// Generates a character range.
/// 
/// Case sensitivity is disabled when passing 2 characters with a different case.
/// Case sensitivity can be set manually with the `caseSensitive` parameter.
/// 
/// ```dart
/// final regex = charRange('B', 'Y', caseSensitive: false, exact: true);
/// 
/// print(regex.hasMatch('b')); // true
/// print(regex.hasMatch('Y')); // true
/// print(regex.hasMatch('Z')); // false
/// ```
RegExp charRange(String min, String max, { bool caseSensitive = false, bool exact = false }) {
  if (min.length != 1 || max.length != 1) {
    throw InvalidRangeInputError(min, max);
  }

  final minChar = min[0];
  final maxChar = max[0];

  if (!caseSensitive && min.hasCaseDifference && max.hasCaseDifference) {
    return RegExp('[${
      RegExp.escape(minChar.toLowerCase()) }-${ RegExp.escape(maxChar.toLowerCase())
    }${
      RegExp.escape(minChar.toUpperCase()) }-${ RegExp.escape(maxChar.toUpperCase())
    }]').shouldBeExact(exact);
  }

  return RegExp('[${ RegExp.escape(minChar) }-${ RegExp.escape(maxChar) }]').shouldBeExact(exact);
}
