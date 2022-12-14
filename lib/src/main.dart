import 'package:regex_range/src/error.dart';
import 'package:regex_range/src/number.dart';
import 'package:regex_range/src/utils/case.dart';
import 'package:regex_range/src/utils/regex.dart';

RegExp range<T>(T min, T max, { bool exact = false }) {
  if (min is int && max is int) {
    return numberRange(min, max, exact: exact);
  } else if (min is String && max is String) {
    return charRange(min, max, ignoreCase: isDifferentCase(min, max), exact: exact);
  } else {
    throw InvalidRangeTypeError(T);
  }
}

RegExp numberRange(int min, int max, { bool exact = false }) {
  return RegexRangeNumber(min, max).regex.shouldBeExact(exact);
}

RegExp charRange(String min, String max, { bool ignoreCase = false, bool exact = false }) {
  if (min.length != 1 || max.length != 1) {
    throw InvalidRangeInputError(min, max);
  }

  if (ignoreCase && !isDifferentCase(min, max)) {
    ignoreCase = false;
  }

  final minChar = min[0];
  final maxChar = max[0];

  if (ignoreCase) {
    return RegExp('[${
      RegExp.escape(minChar.toLowerCase()) }-${ RegExp.escape(maxChar.toLowerCase())
    }${
      RegExp.escape(minChar.toUpperCase()) }-${ RegExp.escape(maxChar.toUpperCase())
    }]').shouldBeExact(exact);
  }

  return RegExp('[${ RegExp.escape(minChar) }-${ RegExp.escape(maxChar) }]').shouldBeExact(exact);
}
