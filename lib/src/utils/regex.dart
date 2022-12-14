extension ExactRegex on RegExp {
  bool get isExact => pattern.startsWith('^') && pattern.endsWith('\$');

  RegExp get exact => isExact ? this : RegExp('^$pattern\$');
  RegExp get notExact => isExact ? RegExp(pattern.substring(1, pattern.length - 1)) : this;

  RegExp shouldBeExact([ bool condition = true ]) => condition ? exact : notExact;
}