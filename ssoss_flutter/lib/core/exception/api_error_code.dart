/// 서버 API 에러 코드.
///
/// 알려진 코드는 상수로 두고, 미등록 코드는 [parse] 가 value 를 그대로 보존한다.
class ApiErrorCode {
  const ApiErrorCode._(this.value);

  final String value;

  static const c0001 = ApiErrorCode._('C0001');
  static const a0001 = ApiErrorCode._('A0001');
  static const a0002 = ApiErrorCode._('A0002');
  static const a0003 = ApiErrorCode._('A0003');
  static const a0004 = ApiErrorCode._('A0004');
  static const a0005 = ApiErrorCode._('A0005');

  /// 등록되지 않은 코드 또는 빈 값.
  bool get isUnknown => switch (value) {
        'C0001' || 'A0001' || 'A0002' || 'A0003' || 'A0004' || 'A0005' => false,
        _ => true,
      };

  factory ApiErrorCode.parse(String? raw) {
    if (raw == null || raw.isEmpty) {
      return const ApiErrorCode._('');
    }
    return switch (raw) {
      'C0001' => c0001,
      'A0001' => a0001,
      'A0002' => a0002,
      'A0003' => a0003,
      'A0004' => a0004,
      'A0005' => a0005,
      _ => ApiErrorCode._(raw),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiErrorCode && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ApiErrorCode($value)';
}
