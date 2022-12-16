[![Pub.dev package](https://img.shields.io/badge/pub.dev-regex__range-blue)](https://pub.dev/packages/regex_range)
[![GitHub repository](https://img.shields.io/badge/GitHub-RegexRange--dart-blue?logo=github)](https://github.com/DrafaKiller/RegexRange-dart)

# Regex Range

Generates a Regular Expression that matches a range of numbers or characters.

## Features

- Number ranges: `1 -> 100`
- Negative to positive number ranges: `-100 -> 100`
- Character ranges: `A -> Z`
- Case insensitive character ranges: `a -> Z`

## Getting Started

```
dart pub add regex_range
```

And import the package:

```dart
import 'package:regex_range/regex_range.dart';
```

## Usage

To generate a regex, you may use the `range` function to generate both number and character ranges, depending on what's passed in.
A number range is generated when passing in 2 numbers, and a character range is generated when passing in 2 strings with a length of 1.

Alternatively, you may use the `numberRange` and `charRange` functions to generate a number or character range, respectively.

### Expression Pattern

You can get the generated expression pattern by using the `pattern` property of the `RegExp` object.

```dart
final regex = range(0, 5, exact: true);

print(regex.pattern); // [0-5]
```

### Number Range

```dart
final regex = range(-10, 10, exact: true);
// or
final regex = numberRange(-10, 10, exact: true);

print(regex.hasMatch('-5')); // true
print(regex.hasMatch('5')); // true
print(regex.hasMatch('11')); // false
```

### Character Range

Case sensitivity is disabled when passing 2 characters with a different case. Case sensitivity can be set manually with the `caseSensitive` parameter in the `charRange` function.

```dart
final regex = range('b', 'Y', exact: true);
// or
final regex = charRange('B', 'Y', caseSensitive: false, exact: true);

print(regex.hasMatch('b')); // true
print(regex.hasMatch('Y')); // true
print(regex.hasMatch('Z')); // false
```

## Generated Regex

The expressions below are not the exact expressions generated by the package, they are the simplified equivalent.

### Number Range

Range   | Expression
------- | ----------
0, 5    | `[0-5]`
0, 10   | `[0-9]\|10`
25, 100 | `2[5-9]\|[3-9][0-9]\|100`
-10, 10 | `-?[0-9]\|-?10`

### Character Range

Range   | Expression
------- | ----------
A, Z    | `[A-Z]`
a, z    | `[a-z]`
a, Z    | `[a-zA-Z]`
b, Y    | `[b-yB-Y]`

## Contributing

Contributions are welcome! Please open an [issue](https://github.com/DrafaKiller/RegexRange-dart/issues) or [pull request](https://github.com/DrafaKiller/RegexRange-dart/pulls) if you find a bug or have a feature request.
