import 'social_provider.dart';

/// 인증된 사용자 정보.
class User {
  const User({
    required this.id,
    required this.nickname,
    required this.provider,
    this.email,
    this.profileImageUrl,
  });

  final String id;
  final String nickname;
  final String? email;
  final String? profileImageUrl;
  final SocialProvider provider;
}
