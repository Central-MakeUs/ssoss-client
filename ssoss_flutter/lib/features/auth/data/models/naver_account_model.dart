import 'package:flutter_naver_login/interface/types/naver_account_result.dart';

/// 네이버 SDK 인증 결과를 담는 모델.
///
/// 네이버 accessToken 과 프로필 정보를 함께 보관한다.
class NaverAccountModel {
  const NaverAccountModel({
    required this.accessToken,
    required this.id,
    required this.nickname,
    this.email,
    this.profileImage,
  });

  final String accessToken;
  final String id;
  final String nickname;
  final String? email;
  final String? profileImage;

  factory NaverAccountModel.fromResult({
    required String accessToken,
    required NaverAccountResult account,
  }) {
    return NaverAccountModel(
      accessToken: accessToken,
      id: account.id ?? '',
      nickname: account.nickname ?? account.name ?? '네이버 사용자',
      email: account.email,
      profileImage: account.profileImage,
    );
  }
}
