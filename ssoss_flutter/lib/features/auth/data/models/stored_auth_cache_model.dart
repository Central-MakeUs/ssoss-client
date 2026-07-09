import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/entities/user.dart';
import 'auth_token_model.dart';

part 'stored_auth_cache_model.freezed.dart';
part 'stored_auth_cache_model.g.dart';

/// 로컬 secure storage 에 영속화하는 인증 세션 캐시.
@freezed
abstract class StoredAuthCacheModel with _$StoredAuthCacheModel {
  const factory StoredAuthCacheModel({
    required AuthTokenModel token,
    required String provider,
    required String userId,
    required String nickname,
    String? email,
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
      );
}
