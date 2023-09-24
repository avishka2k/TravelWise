extension StringExtensions on String {
  String capitalizeword() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

String capitalizedText(String text) {
  return text
      .toString()
      .split(' ')
      .map((word) => word.capitalizeword())
      .join(' ');
}
