/// 매장 영업 시간 표시/API 포맷 변환.
class StoreTimeFormat {
  const StoreTimeFormat._();

  /// 미선택 placeholder (`00:00`).
  static bool isUnset(String? value) {
    if (value == null || value.trim().isEmpty) return true;
    return toApi(value) == '00:00';
  }

  /// 오픈이 마감보다 이른지(둘 다 설정된 경우만 검사).
  static bool isValidRange(String? opening, String? closing) {
    if (isUnset(opening) || isUnset(closing)) return true;
    return _toMinutes(toApi(opening!)) < _toMinutes(toApi(closing!));
  }

  /// `오전/오후 hh:mm` 또는 `HH:mm` → API용 `HH:mm`.
  static String toApi(String value) {
    final trimmed = value.trim();
    final apiMatch =
        RegExp(r'^([01]?\d|2[0-3]):([0-5]\d)$').firstMatch(trimmed);
    if (apiMatch != null) {
      final hour = int.parse(apiMatch.group(1)!);
      final minute = apiMatch.group(2)!;
      return '${hour.toString().padLeft(2, '0')}:$minute';
    }

    final koreanMatch =
        RegExp(r'^(오전|오후)\s*(\d{1,2}):([0-5]\d)$').firstMatch(trimmed);
    if (koreanMatch == null) return trimmed;

    final period = koreanMatch.group(1)!;
    var hour = int.parse(koreanMatch.group(2)!);
    final minute = koreanMatch.group(3)!;

    if (period == '오전' && hour == 12) {
      hour = 0;
    } else if (period == '오후' && hour != 12) {
      hour += 12;
    }

    return '${hour.toString().padLeft(2, '0')}:$minute';
  }

  /// API용 `HH:mm` → 표시용 `오전/오후 hh:mm` (`00:00`은 그대로).
  static String toDisplay(String value) {
    final apiTime = toApi(value);
    final match = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$').firstMatch(apiTime);
    if (match == null || apiTime == '00:00') return apiTime;

    final hour24 = int.parse(match.group(1)!);
    final minute = match.group(2)!;
    final period = hour24 < 12 ? '오전' : '오후';
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    return '$period ${hour12.toString().padLeft(2, '0')}:$minute';
  }

  static int _toMinutes(String apiTime) {
    final parts = apiTime.split(':');
    if (parts.length != 2) return 0;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return hour * 60 + minute;
  }
}
