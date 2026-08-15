/// 콘텐츠 작성 톤 (매장 정보 · 콘텐츠 생성 공통).
enum WritingTone {
  daily('CASUAL', '일상형', '자연스럽고 편안한 말투'),
  emotional('EMOTIONAL', '감성형', '분위기와 감정을 살린 말투'),
  informational(
    'INFORMATIVE',
    '정보형',
    '메뉴, 재료, 특징을 중심으로 설명하는 말투',
  ),
  promotional('PROMOTIONAL', '홍보형', '장점과 방문 유도를 강조하는 말투');

  const WritingTone(this.code, this.label, this.description);

  /// API 코드 (CASUAL / EMOTIONAL / INFORMATIVE / PROMOTIONAL).
  final String code;
  final String label;
  final String description;

  static WritingTone? fromCode(String? code) {
    if (code == null) return null;
    final normalized = code.toUpperCase();
    for (final tone in WritingTone.values) {
      if (tone.code == normalized) return tone;
    }
    // 레거시 별칭
    return switch (normalized) {
      'DAILY' => WritingTone.daily,
      'INFORMATIONAL' => WritingTone.informational,
      _ => null,
    };
  }
}
