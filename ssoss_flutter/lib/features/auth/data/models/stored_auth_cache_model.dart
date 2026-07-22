import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/entities/member_status.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/entities/user.dart';
import 'auth_token_model.dart';

part 'stored_auth_cache_model.freezed.dart';
part 'stored_auth_cache_model.g.dart';

MemberStatus _memberStatusFromJson(Object? value) {
  if (value == null) {
    return MemberStatus.active;
  }
  if (value is String) {
    return MemberStatusX.fromApi(value);
  }
  return MemberStatus.active;
}

String _memberStatusToJson(MemberStatus status) => status.toApi();

/// 로컬 secure storage 에 영속화하는 인증 세션 캐시.
@freezed
abstract class StoredAuthCacheModel with _$StoredAuthCacheModel {
  const factory StoredAuthCacheModel({
    required AuthTokenModel token,
    required String provider,
    required String userId,
    required String nickname,
    String? email,
    @JsonKey(
      fromJson: _memberStatusFromJson,
      toJson: _memberStatusToJson,
    )
    @Default(MemberStatus.active)
    MemberStatus memberStatus,
  }) = _StoredAuthCacheModel;

  factory StoredAuthCacheModel.fromJson(Map<String, dynamic> json) =>
      _$StoredAuthCacheModelFromJson(json);
}

extension StoredAuthCacheModelX on StoredAuthCacheModel {
  AuthSession toEntity() => AuthSession(
        user: User(
          id: userId,
          nickname: nickname,
          email: email,
          provider:
              provider == 'apple' ? SocialProvider.apple : SocialProvider.naver,
        ),
        tokens: token.toEntity(),
        memberStatus: memberStatus,
      );
}
