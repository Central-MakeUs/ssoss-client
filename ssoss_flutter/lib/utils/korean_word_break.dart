extension StringExtension on String {
  String get koreanWordBreak {
    return replaceAllMapped(RegExp(r'(\S)(?=\S)'), (m) => '${m[1]}\u200D');
  }
}
