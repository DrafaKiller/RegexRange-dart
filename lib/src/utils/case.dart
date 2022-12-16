extension StringCase on String {
  bool get hasCaseDifference => toLowerCase() != toUpperCase();

  bool get isLowerCase => hasCaseDifference && toLowerCase() == this;
  bool get isUpperCase => hasCaseDifference && toUpperCase() == this;
}

bool isDifferentCase(String a, String b) => a.isLowerCase != b.isLowerCase;
