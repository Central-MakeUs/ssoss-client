import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_login_request.freezed.dart';
part 'social_login_request.g.dart';

/// `POST /v1/social-logins/{provider}` 요청 바디.
///
/// - naver: `accessToken` = 액세스 토큰, `refreshToken` = 리프레시 토큰
/// - apple: `accessToken` = identity token, `refreshToken` = authorization code
@freezed
abstract class SocialLoginRequest with _$SocialLoginRequest {
  const factory SocialLoginRequest({
    required String accessToken,
    required String refreshToken,
  }) = _SocialLoginRequest;

  factory SocialLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginRequestFromJson(json);
}
