import 'auth_tokens.dart';
import 'member_status.dart';
import 'user.dart';

/// 로그인 결과. 인증된 사용자와 발급된 토큰을 담는다.
class AuthSession {
  const AuthSession({
    required this.user,
    required this.tokens,
    this.memberStatus = MemberStatus.active,
  });

  final User user;
  final AuthTokens tokens;
  final MemberStatus memberStatus;
}
