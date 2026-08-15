import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/social_provider.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String nickname,
    String? email,
    String? profileImageUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  User toEntity(SocialProvider provider) => User(
        id: id,
        nickname: nickname,
        email: email,
        profileImageUrl: profileImageUrl,
        provider: provider,
      );
}
