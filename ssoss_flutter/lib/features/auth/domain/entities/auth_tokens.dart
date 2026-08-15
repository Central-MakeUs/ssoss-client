/// 자체 JWT access / opaque refresh 토큰.
///
/// access 만료는 서버 401 로 감지하고, 인터셉터가 refresh 한다.
class AuthTokens {
  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;
}
