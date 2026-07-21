/// Apple SDK 인증 결과.
class AppleAccountModel {
  const AppleAccountModel({
    required this.userIdentifier,
    this.identityToken,
    this.authorizationCode,
    this.email,
    this.givenName,
    this.familyName,
  });

  final String userIdentifier;
  final String? identityToken;
  final String? authorizationCode;
  final String? email;
  final String? givenName;
  final String? familyName;

  String get nickname {
    final parts = [givenName, familyName]
        .whereType<String>()
        .where((s) => s.isNotEmpty)
        .toList();
    return parts.isEmpty ? 'Apple 사용자' : parts.join(' ');
  }
}
