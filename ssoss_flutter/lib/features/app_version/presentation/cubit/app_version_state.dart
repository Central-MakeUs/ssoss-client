import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version_state.freezed.dart';

@freezed
abstract class AppVersionState with _$AppVersionState {
  /// 버전 조회 중 (스플래시 유지).
  const factory AppVersionState.checking() = AppVersionChecking;

  /// 강제 업데이트가 필요함.
  const factory AppVersionState.updateRequired({
    required String minimumVersion,
  }) = AppVersionUpdateRequired;

  /// 네트워크 오류로 버전 조회 실패. 재시도 모달을 표시한다.
  const factory AppVersionState.networkUnavailable() =
      AppVersionNetworkUnavailable;

  /// 이용 가능하거나 네트워크 외 조회 실패로 소프트 통과.
  const factory AppVersionState.allowed() = AppVersionAllowed;
}
