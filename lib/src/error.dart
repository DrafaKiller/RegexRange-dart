class InvalidRangeInputError extends Error {
  final dynamic from;
  final dynamic to;
  InvalidRangeInputError(this.from, this.to);

  @override
  String toString() => 'Invalid range: $from - $to';
}

class InvalidRangeTypeError extends Error {
  final Type type;
  InvalidRangeTypeError(this.type);

  @override
  String toString() => 'Invalid range type: $type, expected: int or String';
}