import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/member_status.dart';
import 'auth_token_model.dart';

part 'social_login_response_model.freezed.dart';
part 'social_login_response_model.g.dart';

MemberStatus _memberStatusFromJson(String value) =>
    MemberStatusX.fromApi(value);

String _memberStatusToJson(MemberStatus status) => status.toApi();

/// 소셜 로그인·복구 응답 — 회원 상태와 서버 발급 토큰 쌍.
@freezed
abstract class SocialLoginResponseModel with _$SocialLoginResponseModel {
  const factory SocialLoginResponseModel({
    @JsonKey(fromJson: _memberStatusFromJson, toJson: _memberStatusToJson)
    required MemberStatus status,
    required String accessToken,
    required String refreshToken,
  }) = _SocialLoginResponseModel;

  factory SocialLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginResponseModelFromJson(json);
}

extension SocialLoginResponseModelX on SocialLoginResponseModel {
  AuthTokenModel toTokenModel() => AuthTokenModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
}
