import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.freezed.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.naverLoginRequested() = NaverLoginRequested;
  const factory LoginEvent.appleLoginRequested() = AppleLoginRequested;
  const factory LoginEvent.withdrawRequested() = WithdrawRequested;
  const factory LoginEvent.sessionRestoreRequested() = SessionRestoreRequested;
  const factory LoginEvent.logoutRequested() = LogoutRequested;

  /// access invalid + refresh 실패. 로그인 후 화면에서 모달 표시용.
  const factory LoginEvent.sessionExpired() = SessionExpired;

  /// 세션 만료 모달 확인 — 로그인 화면으로 이동.
  const factory LoginEvent.sessionExpiredAcknowledged() =
      SessionExpiredAcknowledged;

  /// 탈퇴 실패 토스트 확인 후 authenticated 복원 (설정 화면 전용).
  const factory LoginEvent.failureAcknowledged() = FailureAcknowledged;

  /// 회원가입 API 성공.
  const factory LoginEvent.signupSucceeded() = SignupSucceeded;

  /// 회원가입 완료 화면 확인 — 홈으로 이동.
  const factory LoginEvent.signupCompleteAcknowledged() =
      SignupCompleteAcknowledged;
}
