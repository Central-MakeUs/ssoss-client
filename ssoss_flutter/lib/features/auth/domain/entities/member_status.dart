/// 서버 회원 상태 (`SocialLoginResponse.status` / JWT `role` 클레임).
enum MemberStatus {
  /// 가입 대기 — 회원가입 API만 호출 가능.
  pending,

  /// 가입 회원 — 전체 API 호출 가능.
  active,

  /// 탈퇴 대기 — 복구 API 전용.
  withdrawn,
}

extension MemberStatusX on MemberStatus {
  static MemberStatus fromApi(String value) {
    switch (value.toUpperCase()) {
      case 'PENDING':
        return MemberStatus.pending;
      case 'ACTIVE':
        return MemberStatus.active;
      case 'WITHDRAWN':
        return MemberStatus.withdrawn;
      default:
        throw FormatException('Unknown member status: $value');
    }
  }

  String toApi() {
    switch (this) {
      case MemberStatus.pending:
        return 'PENDING';
      case MemberStatus.active:
        return 'ACTIVE';
      case MemberStatus.withdrawn:
        return 'WITHDRAWN';
    }
  }
}
