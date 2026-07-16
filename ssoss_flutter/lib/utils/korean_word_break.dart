import 'package:characters/characters.dart';

extension StringExtension on String {
  /// 어절(공백 구분) 안에서 글자 사이에 ZWJ를 넣어 단어 중간 줄바꿈을 막는다.
  ///
  /// UTF-16 코드 유닛이 아니라 grapheme cluster 단위로 처리해
  /// 이모지(💰 등) surrogate pair가 깨지지 않게 한다.
  String get koreanWordBreak {
    if (isEmpty) {
      return this;
    }

    final buffer = StringBuffer();
    final graphemes = characters.toList(growable: false);

    for (var i = 0; i < graphemes.length; i++) {
      final current = graphemes[i];
      buffer.write(current);

      if (i >= graphemes.length - 1) {
        continue;
      }

      final next = graphemes[i + 1];
      if (current.trim().isNotEmpty && next.trim().isNotEmpty) {
        buffer.write('\u200D');
      }
    }

    return buffer.toString();
  }
}
