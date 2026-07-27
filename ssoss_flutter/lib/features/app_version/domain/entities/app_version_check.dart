/// 앱 버전 조회 결과 — 최소 지원 버전과 업데이트 필요 여부.
class AppVersionCheck {
  const AppVersionCheck({
    required this.minimumVersion,
    required this.updateRequired,
  });

  final String minimumVersion;
  final bool updateRequired;
}
