extension StringCase on String {
  bool get hasCaseDifference => toLowerCase() != toUpperCase();

  bool get isLowerCase => hasCaseDifference && toLowerCase() == this;
  bool get isUpperCase => hasCaseDifference && toUpperCase() == this;
}

bool isDifferentCase(String min, String max) => min.isLowerCase != max.isLowerCase;
