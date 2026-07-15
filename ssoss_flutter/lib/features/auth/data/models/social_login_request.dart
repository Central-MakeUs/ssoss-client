import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_login_request.freezed.dart';
part 'social_login_request.g.dart';

/// `POST /v1/social-logins/{provider}` 요청 바디.
@freezed
abstract class SocialLoginRequest with _$SocialLoginRequest {
  const factory SocialLoginRequest({
    required String accessToken,
  }) = _SocialLoginRequest;

  factory SocialLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginRequestFromJson(json);
}
