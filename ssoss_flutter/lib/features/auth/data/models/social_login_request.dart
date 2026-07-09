import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_login_request.freezed.dart';
part 'social_login_request.g.dart';

/// 백엔드 소셜 로그인 요청 바디 (Phase 7 에서 사용).
@freezed
abstract class SocialLoginRequest with _$SocialLoginRequest {
  const factory SocialLoginRequest({
    required String provider,
    String? accessToken,
    /// Apple credential (Phase 7).
    String? identityToken,
    String? authorizationCode,
  }) = _SocialLoginRequest;

  factory SocialLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginRequestFromJson(json);
}
